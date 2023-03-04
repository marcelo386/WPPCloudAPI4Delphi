{
####################################################################################################################
  Obs:
     - Código aberto a comunidade Delphi, desde que mantenha os dados dos autores e mantendo sempre o nome do IDEALIZADOR
       Marcelo dos Santos de Oliveira;

####################################################################################################################
                                  Evolução do Código
####################################################################################################################
  Autor........: Marcelo Oliveira
  Email........: marcelo.broz@hotmail.com
  Data.........: 01/03/2023
  Identificador: @Marcelo
  Modificação..:
####################################################################################################################
}
unit uWPPCloudAPI;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient, IdSSLOpenSSL, IdHTTP,
  uRetMensagemApiOficial, StrUtils, Horse, Horse.Commons,  Horse.Core, web.WebBroker,
  RESTRequest4D, REST.Types, REST.Client, System.Net.Mime;


type
  {Events}
  TOnRetSendMessage = Procedure(Sender : TObject; Response: string) of object;
  TResponseEvent = Procedure(Sender : TObject; Response: string) of object;

  TWPPCloudAPI = class(TComponent)

  private
    FDDIDefault: Integer;
    FTokenApiOficial: string;
    FOnRetSendMessage: TOnRetSendMessage;
    FOnResponse: TResponseEvent;
    FPHONE_NUMBER_ID: string;
    FPort: Integer;
    function CaractersWeb(vText: string): string;
  protected


  public
    //Individual
    function SendText(waid, body: string; previewurl: string = 'false'): string;
    function SendFile(waid, body, typeFile, url: string): string;
    function SendButton(waid, body, actions, header, footer: string): string;
    function SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
    function SendContact(waid, phoneNumber, formatted_name, options: string): string;
    function SendLocation(waid, body, Location, header, footer: string): string;
    function SendReaction(waid, message_id, emoji: string): string;
    function SendReplies(waid, message_id, reply_body: string; previewurl: string = 'false'): string;
    function MarkIsRead(waid, message_id: string): string;

    //Template
    function Send_Template_hello_world(waid: string): string;
    function Send_Template(jsonTemplate: string): string;

    function TemplateGet(): string;
    function TemplateCreate(jsonTemplate: string): string;
    function TemplateDelete(AName: string): string;

    function UploadMedia(FileName: string): string;
    function PostMediaFile(FileName, MediaType: string): string;

    procedure StartServer;
    procedure StopServer;

  published
    property TokenApiOficial  : string             read FTokenApiOficial   write FTokenApiOficial;
    property PHONE_NUMBER_ID  : string             read FPHONE_NUMBER_ID   write FPHONE_NUMBER_ID;
    property DDIDefault       : Integer            read FDDIDefault        write FDDIDefault         Default 55;
    property Port             : Integer            read FPort              write FPort               Default 8020;
    property OnRetSendMessage : TOnRetSendMessage  read FOnRetSendMessage  write FOnRetSendMessage;
    property OnResponse       : TResponseEvent     read FOnResponse        write FOnResponse;

  end;



procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('WPPCloudAPI', [TWPPCloudAPI]);
end;

{ TWPPCloudAPI }


function TWPPCloudAPI.CaractersWeb(vText: string): string;
begin
  vText  := StringReplace(vText, sLineBreak,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, '<br>'    ,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, '<br />'  ,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, '<br/>'   ,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, #13       ,''    , [rfReplaceAll] );
  vText  := StringReplace(vText, '\r'      ,''    , [rfReplaceAll] );
  vText  := StringReplace(vText, '"'       ,'\"' , [rfReplaceAll] );
  vText  := StringReplace(vText, #$A       ,' \n'   , [rfReplaceAll] );
  vText  := StringReplace(vText, #$A#$A    ,' \n'   , [rfReplaceAll] );
  Result := vText;
end;

function TWPPCloudAPI.MarkIsRead(waid, message_id: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "status": "read", ' +
      '  "message_id": "' + message_id + '" ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;


      //gravar_log(response);
    except
      on E: Exception do
      begin
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak + json + SLineBreak;
        Exit;
      end;
    end;

    Result := response;


  finally
  end;

end;

function TWPPCloudAPI.SendButton(waid, body, actions, header, footer: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
begin
  Result := '';
  try

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "interactive", ' +
      '  "interactive": {  ' +
      '  "type": "button", ' +
      IfThen( Trim(header) <> '' ,
      '  "header": { ' +
      '    "type": "text",  ' +
      '    "text": "' + header + '"  ' +
      '  }, ', '') +

      '  "body": { ' +
      '    "text": "' + body + '" ' +
      '  }, ' +

      IfThen( Trim(footer) <> '' ,
      '  "footer": { ' +
      '    "text": "' + footer + '" ' +
      '  }, ', '') +
      actions +

      (*
      '  "action": { ' +
      '    "buttons": [ ' +
      '      {  ' +
      '        "type": "reply", ' +
      '        "reply": { ' +
      '          "id": "UNIQUE_BUTTON_ID_1", ' +
      '          "title": "SIM" ' +
      '        } ' +
      '      }, ' +
      '      {  ' +
      '        "type": "reply", ' +
      '        "reply": { ' +
      '          "id": "UNIQUE_BUTTON_ID_2", ' +
      '          "title": "NÃO" ' +
      '        } ' +
      '      } ' +
      '    ]  ' +
      '  } ' +
      ' } ' +
      *)

      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;

      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error';
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;

end;

function TWPPCloudAPI.SendContact(waid, phoneNumber, formatted_name, options: string): string;
var
  http: TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;
  postData: TStringStream;
  response: string;
  json: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    //body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "contacts", ' +
      '  "contacts": [{  ' +
      '    "addresses": [{ ' +
      '        "street": "STREET", ' +
      '        "city": "VOTUPORANGA", ' +
      '        "state": "SP", ' +
      '        "zip": "", ' +
      '        "country": "", ' +
      '        "country_code": "55", ' +
      '        "type": "HOME" ' +
      '      }, ' +
      '      { ' +
      '        "street": "STREET", ' +
      '        "city": "CITY", ' +
      '        "state": "STATE", ' +
      '        "zip": "ZIP", ' +
      '        "country": "COUNTRY", ' +
      '        "country_code": "55", ' +
      '        "type": "WORK" ' +
      '      }], ' +
      '    "birthday": "", ' +
      '    "emails": [{ ' +
      '        "email": "", ' +
      '        "type": "WORK" ' +
      '      }, ' +
      '      { ' +
      '        "email": "", ' +
      '        "type": "HOME" ' +
      '      }], ' +
      '    "name": { ' +
      '      "formatted_name": "' + formatted_name + '", ' +
      '      "first_name": "' + formatted_name + '", ' +
      '      "last_name": "", ' +
      '      "middle_name": "", ' +
      '      "suffix": "", ' +
      '      "prefix": "" ' +
      '    }, ' +
      '    "org": { ' +
      '      "company": "", ' +
      '      "department": "", ' +
      '      "title": "" ' +
      '    }, ' +
      '    "phones": [{ ' +
      '       "phone": "' + phoneNumber + '", ' +
      '       "type": "HOME", ' +
      '       "wa_id": "' + phoneNumber + '" ' +
      '     } ' +
      //'     { ' +
      //'       "phone": "PHONE_NUMBER", ' +
      //'       "type": "WORK", ' +
      //'       "wa_id": "PHONE_OR_WA_ID" ' +
      '      ] ' +
      '  }] ' +
      '}';

    UTF8Texto := UTF8Encode(json);
    try

      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;


      //gravar_log(response);
    except
      on E: Exception do
      begin
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        //MemoLogApiOficial.Lines.Add(json + SLINEBREAK);
        Result := 'Error ' + e.Message + SLINEBREAK;
        //MemoLogApiOficial.Lines.Add(response);
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
  end;

end;

function TWPPCloudAPI.SendFile(waid, body, typeFile, url: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "' + typeFile + '", ' +
      '  "' + typeFile + '": {  ' +
      '    "link": "' + url + '"  ' +
      //'    ,"caption": "' + body + '"  ' +
      IfThen( Trim(body) <> '' ,' ,"caption": "' + body + '"  ', '') +
      '    } ' +
      '}';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;

      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        //MemoLogApiOficial.Lines.Add(json + SLINEBREAK);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    //MemoLogApiOficial.Lines.Add(response);
    //MemoLogApiOficial.Lines.Add('');
    //MemoLogApiOficial.Lines.Add('Unique id: ' + MessagePayload.Messages[0].ID);
    //gravar_log('Unique id: ' + MessagePayload.Messages[0].ID);
  finally
  end;

end;

function TWPPCloudAPI.SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "interactive", ' +
      '  "interactive": {  ' +
      '    "type": "list", ' +
      IfThen( Trim(header) <> '' ,
      '    "header": { ' +
      '      "type": "text",  ' +
      '      "text": "' + header + '"  ' +
      '    }, ', '') +

      '    "body": { ' +
      '      "text": "' + body + '" ' +
      '    }, ' +

      IfThen( Trim(footer) <> '' ,
      '    "footer": { ' +
      '      "text": "' + footer + '" ' +
      '    }, ', '') +

      '    "action": { ' +
      '      "button": "' + Button_Text + '", ' +

      Sections +
      (*
      '      "sections": [  ' +
      '      {   ' +
      '        "title": "SECTION_1_TITLE", ' +
      '        "rows": [ ' +
      '        { ' +
      '          "id": "SECTION_1_ROW_1_ID", ' +
      '          "title": "SECTION_1_ROW_1_TITLE", ' +
      '          "description": "SECTION_1_ROW_1_DESCRIPTION" ' +
      '        }, ' +
      '        {  ' +
      '          "id": "SECTION_1_ROW_2_ID", ' +
      '          "title": "SECTION_1_ROW_2_TITLE", ' +
      '          "description": "SECTION_1_ROW_2_DESCRIPTION" ' +
      '        } ' +
      '      ] ' +
      '      }, ' +
      '      { ' +
      '        "title": "SECTION_2_TITLE",  ' +
      '        "rows": [  ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_1_ID", ' +
      '          "title": "SECTION_2_ROW_1_TITLE", ' +
      '          "description": "SECTION_2_ROW_1_DESCRIPTION" ' +
      '        }, ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_2_ID", ' +
      '          "title": "SECTION_2_ROW_2_TITLE", ' +
      '          "description": "SECTION_2_ROW_2_DESCRIPTION"  ' +
      '          } ' +
      '         ] ' +
      '        } ' +
      '      ] ' +
      *)

      '  } ' +
      ' } ' +
      '}';

    //json := Trim(json);
    //json := EscapeJsonString(json);
    UTF8Texto := UTF8Encode(json);

    try

      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;

      //gravar_log(response);
    except
      on E: Exception do
      begin

        //MemoLogApiOficial.Lines.Add(json + SLINEBREAK);
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error';
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;

end;

function TWPPCloudAPI.SendLocation(waid, body, Location, header, footer: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      //'  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "location", ' +

      (*
      IfThen( Trim(header) <> '' ,
      '  "header": { ' +
      '    "type": "text",  ' +
      '    "text": "' + header + '"  ' +
      '  }, ', '') +

      IfThen( Trim(body) <> '' ,
      '  "body": { ' +
      '    "text": "' + body + '" ' +
      '  }, ', '') +

      IfThen( Trim(footer) <> '' ,
      '  "footer": { ' +
      '    "text": "' + footer + '" ' +
      '  }, ', '') +
      *)

      Location +
      '}';

    UTF8Texto := UTF8Encode(json);

    try

      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak + json + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
  end;

end;

function TWPPCloudAPI.SendReaction(waid, message_id, emoji: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
begin
  Result := '';


  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "reaction", ' +
      '  "reaction": { ' +
      '    "message_id": "' + message_id + '", ' +
      '    "emoji": "' + emoji + '" ' +
      '  } ' +
      '}';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak + json + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally

  end;

end;

function TWPPCloudAPI.SendReplies(waid, message_id, reply_body: string; previewurl: string): string;
var
  response: string;
  json: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  Result := '';

  try


    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    reply_body := CaractersWeb(reply_body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '   "context": { ' +
      '     "message_id": "' + message_id + '" ' +
      '   }, ' +
      '  "to": "' + waid + '", ' +
      '  "type": "text", ' +
      '  "text": {  ' + // the text object
      '    "preview_url": ' + previewurl + ',  ' +
      '    "body": "' + reply_body + '"  ' +
      '    } ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;

end;

function TWPPCloudAPI.SendText(waid, body, previewurl: string): string;
var
  response: string;
  json: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "text", ' +
      '  "text": {  ' + // the text object
      '    "preview_url": ' + previewurl + ',  ' +
      '    "body": "' + body + '"  ' +
      '    } ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    //MemoLogApiOficial.Lines.Add(response);
    //MemoLogApiOficial.Lines.Add('');
    //MemoLogApiOficial.Lines.Add('Unique id: ' + MessagePayload.Messages[0].ID);
    //gravar_log('Unique id: ' + MessagePayload.Messages[0].ID);
  finally
  end;


end;

function TWPPCloudAPI.Send_Template(jsonTemplate: string): string;
var
  response, json: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
begin

  try
    json := jsonTemplate;
    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post
        .Content;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
  end;
end;

function TWPPCloudAPI.Send_Template_hello_world(waid: string): string;
var
  response, json: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json := '{ "messaging_product": "whatsapp", "to": "' + waid + '", "type": "template", "template": { "name": "hello_world", "language": { "code": "en_US" } } }';
    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/messages')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .Post.Content;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;
end;

procedure TWPPCloudAPI.StartServer;
begin
  THorse
    .Post('/responsewebhook',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponse) then
          FOnResponse(Self, Response);
      end
    );

  if Port = 0 then
    Port := 8020;

  THorse.Port := Port;
  THorse.Listen;
end;

procedure TWPPCloudAPI.StopServer;
begin
  THorse.StopListen;
end;

function TWPPCloudAPI.TemplateCreate(jsonTemplate: string): string;
var
  response, json: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
  Retorno: IResponse;
begin
  try
    json := jsonTemplate;
    UTF8Texto := UTF8Encode(json);
    try
      Retorno:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/message_templates')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto)
        .post;
     response := Retorno.Content;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    MessagePayload := TMessagePayload.FromJSON(response);
    Result := response;//MessagePayload.Messages[0].ID;
  finally
  end;
end;

function TWPPCloudAPI.TemplateDelete(AName: string): string;
var
  response: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
  Retorno: IResponse;
begin
  try
    try
      Retorno:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/message_templates')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .AddBody('{"name":"'+AName+'"}')
        .Delete;
      response := Retorno.Content;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


    Result := response;
  finally
  end;
end;

function TWPPCloudAPI.TemplateGet: string;
var
  response: string;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  Retorno: IResponse;
begin
  try

    try
      Retorno:= TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/message_templates')
        .ContentType('application/json')
        .TokenBearer(TokenApiOficial)
        .Get;
      if Retorno.StatusCode in [200,201] then
      begin
         response := Retorno.Content;
         MessagePayload := TMessagePayload.FromJSON(response);
        // if MessagePayload.Messages<>nil then
         Result := response;//MessagePayload.Messages[0].ID;
      end;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;
end;

function TWPPCloudAPI.PostMediaFile(FileName, MediaType: string): string;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  MediaID: string;
  AccessToken: string;
  FilePath: string;
  //MediaType: string;
  MessagingProduct: string;
  RequestBody: TMultipartFormData;
begin
  MediaID := PHONE_NUMBER_ID;//'123456';
  AccessToken := TokenApiOficial;//'<ACCESS_TOKEN>';
  FilePath := 'C:\Users\megao\Desktop\Temp\ArquivosTesteEnviar\Carta de Cobrança2.pdf';
  MediaType := 'document/pdf';
  MessagingProduct := 'whatsapp';

  // Criando o objeto TRESTClient e configurando as propriedades básicas
  RESTClient := TRESTClient.Create('https://graph.facebook.com/v15.0/');
  RESTClient.Accept := 'application/json';
  RESTClient.ContentType := 'multipart/form-data';
  RESTClient.Params.AddItem('access_token', AccessToken, pkGETorPOST);

  // Criando o objeto TRESTRequest e configurando as propriedades básicas
  RESTRequest := TRESTRequest.Create(RESTClient);
  RESTRequest.Method := rmPOST;
  RESTRequest.Resource := MediaID + '/media';

  // Criando o objeto TMultipartFormData e adicionando os campos da requisição
  RequestBody := TMultipartFormData.Create;
  //RequestBody.AddFile('file', FilePath, MediaType);
  //RequestBody.AddField('type', MediaType, 'text/plain');
  //RequestBody.AddField('messaging_product', MessagingProduct, 'text/plain');

  RequestBody.AddFile('file', FilePath);
  RequestBody.AddField('type', MediaType);
  RequestBody.AddField('messaging_product', MessagingProduct);

  // Configurando o corpo da requisição com o objeto TMultipartFormData
  RESTRequest.AddParameter('multipart/form-data', RequestBody.ToString, pkREQUESTBODY);
  //RESTRequest.AddParameter('multipart/form-data', RequestBody);

  // Executando a requisição e obtendo a resposta
  RESTResponse := TRESTResponse.Create(RESTRequest);
  try
    try
      RESTRequest.Execute;
      Result := RESTResponse.Content;
    except
      on E: Exception do
      begin
        Result := e.Message;
        Exit;
      end;
    end;


    // processar a resposta aqui...
  finally
    RESTResponse.Free;
  end;
end;


function TWPPCloudAPI.UploadMedia(FileName: string): string;
var
  http: TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;
  postData: TStringStream;
  response, json, media_id: string;
  Retorno: IResponse;
  MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UTF8Texto: UTF8String;
  Stream: TFileStream;
  Buffer: TBytes;
  Reader: TStreamReader;
  Str: string;
begin
  try
    //Stream := TFileStream.Create('C:\Users\megao\Desktop\Comunidade_48x48.png', fmOpenRead or fmShareDenyWrite);
    //FileName := '\\LAPTOP-3HVUPL9K\ArquivosTesteEnviar\Carta de Cobrança2.pdf';
    FileName := '\\localhost\ArquivosTesteEnviar\Carta_de_Cobrança2.pdf';
    try
      //SetLength(Buffer, Stream.Size);
      //Stream.Read(Buffer[0], Length(Buffer));
      //Reader := TStreamReader.Create(Stream);
      //Str := Reader.ReadToEnd();

      json :=
        '  { ' +
        '    "messaging_product": "whatsapp", ' +
        '    "file": "' + FileName + '",' +
        '    "type": "document/pdf" ' +
        '  } ';

      UTF8Texto := UTF8Encode(json);

      (*http := TIdHTTP.Create;
      ssl := TIdSSLIOHandlerSocketOpenSSL.Create(http);
      try
        http.IOHandler := ssl;
        http.Request.ContentType := 'multipart/form-data';
        //http.Request.ContentType := 'application/json';
        http.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + TokenApiOficial;


        //postData := TStringStream.Create(UTF8Texto);


        media_id := PHONE_NUMBER_ID;

        try
          //response := http.Post('https://graph.facebook.com/v13.0/' + PHONE_NUMBER_ID + '/media', postData);
          //response := http.Post('https://graph.facebook.com/v15.0/' + media_id + '/media', postData);
          response := http.Post('https://graph.facebook.com/v15.0/' + media_id + '/media', UTF8Texto);
        except
          on E: Exception do
          begin
            Result := 'Error: ' + e.Message + #13#10 + FileName + #13#10;
            Exit;
          end;
        end;
        *)
     try
        //
        try
          Retorno := TRequest.New.BaseURL('https://graph.facebook.com/v15.0/' + PHONE_NUMBER_ID + '/media')
            .ContentType('multipart/form-data')
            //.ContentType('application/json')
            .TokenBearer(TokenApiOficial)
            .AddField('messaging_product', 'whatsapp')
            .AddField('type', 'application/pdf')
            .AddFile('file', FileName)
            //.AddBody(UTF8Texto)
            .Post;
            //.Post.Content;

          Response := Retorno.Content;
        except
          on E: Exception do
          begin
            Result := 'Error: ' + e.Message;
            Exit;
          end;
        end;



        if Assigned(FOnRetSendMessage) then
          FOnRetSendMessage(Self, Response);
        //MessagePayload := TMessagePayload.FromJSON(response);
        //Result := MessagePayload.Messages[0].ID;
        Result := response;

      finally
        postData.Free;
        ssl.Free;
        http.Free;
      end;
      //WriteLn(Format('Received %d bytes of data.', [Length(Buffer)]));
    finally
      //Stream.Free;
      //Reader.Free;
    end;
    //WriteLn('Finished reading the file.');
  except
    on E: Exception do
    begin
      //WriteLn('Encountered an error while reading the file: ' + E.Message);
      Exit;
    end;
  end;

end;

end.
