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
unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, uWPPCloudAPI,
  uWhatsAppBusinessClasses, IniFiles, System.IOUtils, Vcl.Buttons, Vcl.Imaging.pngimage, DateUtils;

type
  TfrmPrincipal = class(TForm)
    edtTokenAPI: TEdit;
    Label1: TLabel;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ed_num: TLabeledEdit;
    mem_message: TMemo;
    edtURL: TLabeledEdit;
    PageControl1: TPageControl;
    tsImage: TTabSheet;
    Image1: TImage;
    lblCaminhoImagem: TLabel;
    tsBase64: TTabSheet;
    Memo1: TMemo;
    gbAcoesBasicas: TGroupBox;
    btnLocalizacaoBotao: TButton;
    btnLink: TButton;
    btnImagemBotao: TButton;
    btnImagem: TButton;
    btnVideoBotao: TButton;
    btnVideo: TButton;
    btnListaMenu: TButton;
    btnBotaoSimples: TButton;
    btnTextoSimples: TButton;
    btnAudio: TButton;
    btnContato: TButton;
    btnSticker: TButton;
    btnLocalizacao: TButton;
    btnArquivo: TButton;
    Button2: TButton;
    WPPCloudAPI1: TWPPCloudAPI;
    Label3: TLabel;
    memResponse: TMemo;
    edtHeader: TLabeledEdit;
    edtFooter: TLabeledEdit;
    edtButtonText: TLabeledEdit;
    edtNumberShared: TLabeledEdit;
    edtNameContactShared: TLabeledEdit;
    Label4: TLabel;
    Button1: TButton;
    Button3: TButton;
    btnReagir: TButton;
    edtMessage_id: TLabeledEdit;
    btnResponder: TButton;
    BitBtn2: TButton;
    OpenDialog1: TOpenDialog;
    edtPHONE_NUMBER_ID: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    Label6: TLabel;
    edtPORT_SERVER: TEdit;
    Label7: TLabel;
    edtDDI_Default: TEdit;
    Image2: TImage;
    Label8: TLabel;
    procedure btnTextoSimplesClick(Sender: TObject);
    procedure btnBotaoSimplesClick(Sender: TObject);
    procedure btnListaMenuClick(Sender: TObject);
    procedure btnContatoClick(Sender: TObject);
    procedure btnLinkClick(Sender: TObject);
    procedure btnImagemClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnLocalizacaoClick(Sender: TObject);
    procedure btnReagirClick(Sender: TObject);
    procedure btnResponderClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnArquivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WPPCloudAPI1Response(Sender: TObject; Response: string);
    procedure SalvarIni;
    procedure LerConfiguracoes;
    procedure BitBtn1Click(Sender: TObject);
    procedure WPPCloudAPI1RetSendMessage(Sender: TObject; Response: string);
  private
    { Private declarations }
    function GerarGUID: string;
  public
    { Public declarations }
    sResponse: string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
begin
  SalvarIni;
end;

procedure TfrmPrincipal.BitBtn2Click(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;

  //SendReaction(waid, message_id, emoji: string)
  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.MarkIsRead(ed_num.Text, edtMessage_id.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnArquivoClick(Sender: TObject);
var
  caption, Type_File : string;
  caminhoArquivo : string;
  isFigurinha : Boolean;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  {if Trim(mem_message.Text) = '' then //Opocional
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
  end;}

  {if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK FILE TO BE SENT');
    edtURL.SetFocus;
    Exit;
  end;}

  sResponse := WPPCloudAPI1.UploadMedia('');
  //sResponse := WPPCloudAPI1.PostMediaFile('','');
  memResponse.Lines.Add(sResponse);

  {OpenDialog1.Execute();

  if FileExists(OpenDialog1.FileName) then
    caminhoArquivo := OpenDialog1.FileName
  else
    Exit;

  isFigurinha := False;}

  Type_File := 'image';

  //WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  //WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  //sResponse := WPPCloudAPI1.SendFile(ed_num.Text, mem_message.Text, 'image', edtURL.Text);



  //sResponse := WPPCloudAPI1.SendFile(ed_num.Text, mem_message.Text, 'document', 'https://we.tl/t-Xy3U9kbKUH');
  //memResponse.Lines.Add(sResponse);

end;

procedure TfrmPrincipal.btnBotaoSimplesClick(Sender: TObject);
var
  sAction : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;

  sAction :=
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
      ' } ';


  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendButton(ed_num.Text, mem_message.Text, sAction, edtHeader.Text, edtFooter.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnContatoClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('Informe o Número do WhatsApp');
    ed_num.Setfocus;
    Exit;
  end;

  if mem_message.Text = '' then
  begin
    ShowMessage('Informe o Número do WhatsApp que deseja Compartilhar');
    mem_message.Setfocus;
    Exit;
  end;

  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendContact(ed_num.Text, edtNumberShared.Text, edtNameContactShared.Text, '');

end;

procedure TfrmPrincipal.btnImagemClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  {if Trim(mem_message.Text) = '' then //Opocional
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
  end;}

  if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK FILE TO BE SENT');
    edtURL.SetFocus;
    Exit;
  end;

  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendFile(ed_num.Text, mem_message.Text, 'image', edtURL.Text);

  //sResponse := WPPCloudAPI1.SendFile(ed_num.Text, mem_message.Text, 'document', 'https://we.tl/t-Xy3U9kbKUH');

  memResponse.Lines.Add(sResponse);

end;

procedure TfrmPrincipal.btnLinkClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
  end;

  {if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
  end;}

  if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK PREVIEW TO BE SENT');
    edtURL.SetFocus;
  end;

  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendText(ed_num.Text, edtURL.Text, 'true');

  memResponse.Lines.Add(sResponse);

end;

procedure TfrmPrincipal.btnListaMenuClick(Sender: TObject);
var
  sSections : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;

  if Trim(edtButtonText.Text) = '' then
  begin
    ShowMessage('INFORM THE BUTTON TEXT');
    edtButtonText.SetFocus;
    Exit;
  end;


  sSections :=
      '  "sections": [  ' +
      '    {   ' +
      '      "title": "SECTION_1_TITLE", ' +
      '      "rows": [ ' +
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
      '    }, ' +
      '    { ' +
      '      "title": "SECTION_2_TITLE",  ' +
      '      "rows": [  ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_1_ID", ' +
      '          "title": "SECTION_2_ROW_1_TITLE", ' +
      '          "description": "SECTION_2_ROW_1_DESCRIPTION" ' +
      '        }, ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_2_ID", ' +
      '          "title": "SECTION_2_ROW_2_TITLE", ' +
      '          "description": "SECTION_2_ROW_2_DESCRIPTION"  ' +
      '        } ' +
      '      ] ' +
      '     } ' +
      '    ] ';



  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendListMenu(ed_num.Text, mem_message.Text, sSections, edtHeader.Text, edtFooter.Text, edtButtonText.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnLocalizacaoClick(Sender: TObject);
var
  sLocation : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  {if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;}

  sLocation :=
      '  "location": { ' +
      '      "longitude": -70.4078, ' +
      '      "latitude": 25.3789, ' +
      '      "name": "Cristo Rendedor", ' +
      '      "address": "Rio de Janeiro-RJ" ' +
      ' } ';

  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendLocation(ed_num.Text, mem_message.Text, sLocation, edtHeader.Text, edtFooter.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnReagirClick(Sender: TObject);
var
  sEmoji : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;

  sEmoji := '\uD83D\uDE00';

  //SendReaction(waid, message_id, emoji: string)
  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendReaction(ed_num.Text, edtMessage_id.Text, sEmoji);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnResponderClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE REPLY BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;


  //SendReaction(waid, message_id, emoji: string)
  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendReplies(ed_num.Text, edtMessage_id.Text, mem_message.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnTextoSimplesClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;

  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.SendText(ed_num.Text, mem_message.Text);

  memResponse.Lines.Add(sResponse);

end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.Send_Template_hello_world(ed_num.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
var
  jsonTemplate: string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  //Exemplo
  jsonTemplate :=
      '{"messaging_product":"whatsapp","to":"' + ed_num.Text + '","type":"template",' +
      '"template":{"name":"teste_botoes","language":{"code":"pt_BR","policy":"deterministic"},' +
      '"components":[{"type":"body",' +
      '"parameters":[' +
        '{"type":"text","text":"Marcelo"},' +
        '{"type":"text","text":"DO SEU RETORNO"},' +
        '{"type":"text","text":"CARDIOLOGIA"},' +
        '{"type":"text","text":"DR GUILHERME"},' +
        '{"type":"text","text":"25/02/2023"},' +
        '{"type":"text","text":"07:30"},' +
        '{"type":"text","text":"17 3000-0000"},' +
        '{"type":"text","text":"17 99999-9999"}' +
      ']},' +
      '{"type":"button","sub_type":"quick_reply","index":0,"parameters":[{"type":"text","text":"SIM"}]},' +
      '{"type":"button","sub_type":"quick_reply","index":1,"parameters":[{"type":"text","text":"NÃO"}]} ]}}';


  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.Send_Template(jsonTemplate);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  WPPCloudAPI1.Port := 8020;
  LerConfiguracoes;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  WPPCloudAPI1.DDIDefault := StrToIntDef(edtDDI_Default.Text, 55);
  WPPCloudAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8020);
  WPPCloudAPI1.StartServer;
end;

function TfrmPrincipal.GerarGUID: string;
var
  Guid: TGUID;
begin
  Guid := TGUID.NewGuid;
  Result := Guid.ToString;
end;

procedure TfrmPrincipal.LerConfiguracoes;
var
  NomeArquivo: string;
  ArquivoConfig: TCustomIniFile;
begin
  NomeArquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), 'WPPCloudAPI.ini ');
  ArquivoConfig := TMemIniFile.Create(NomeArquivo);

  edtTokenAPI.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'TokenAPI', '');
  edtPHONE_NUMBER_ID.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PHONE_NUMBER_ID', '');
  edtPORT_SERVER.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_SERVER', '8020');
  edtDDI_Default.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'DDI_Default', '55');

  ArquivoConfig.UpdateFile;

  FreeAndNil(ArquivoConfig);

end;

procedure TfrmPrincipal.SalvarIni;
var
  NomeArquivo: string;
  ArquivoConfig: TCustomIniFile;
begin
  NomeArquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), 'WPPCloudAPI.ini ');
  ArquivoConfig := TMemIniFile.Create(NomeArquivo);

  ArquivoConfig.writeString('CONFIGURACAO', 'TokenAPI', edtTokenAPI.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PHONE_NUMBER_ID', edtPHONE_NUMBER_ID.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_SERVER', edtPORT_SERVER.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'DDI_Default', edtDDI_Default.Text);

  ArquivoConfig.UpdateFile;

  FreeAndNil(ArquivoConfig);

  LerConfiguracoes;
end;

procedure TfrmPrincipal.WPPCloudAPI1Response(Sender: TObject; Response: string);
var
  Result: uWhatsAppBusinessClasses.TResultClass;
  ChatId, IdMensagem, S_Type, Body, S_Caption, fromId, phone_number_id, profile_name,
    clienturl, mediakey, MimeType, FileName, Extensao, wlo_NomeArquivo, url,
    SelectButtonId, SelectRowId, idMensagemOrigem, description,
    Title, Footer, quotedMsg_body, quotedMsg_caption, S_Type_origem, status, recipient_id : string;
    sDataEnv, sDataRec, reaction_emoji, reaction_message_id, wlo_ack, wlo_status,
    error_Message, error_Code, error_title, error_data_details : string;
    auxData: Int64;
  eh_arquivo : Boolean;
begin

  memResponse.Lines.Add('' + Response + #13#10);

  try
    Result := uWhatsAppBusinessClasses.TResultClass.FromJsonString(Response);

    ChatId := '';
    fromId := '';
    phone_number_id := '';
    profile_name := '';
    IdMensagem := '';
    S_Type := '';
    Body := '';
    S_Caption := '';
    SelectButtonId := '';
    SelectRowId := '';
    description := '';
    clienturl := '';
    mediakey := '';
    MimeType := '';
    FileName := '';
    Extensao := '';
    wlo_NomeArquivo := '';
    url := '';
    idMensagemOrigem := '';
    quotedMsg_body := '';
    quotedMsg_caption := '';
    S_Type_origem := '';
    Title := '';
    Footer := '';
    recipient_id := '';
    status := '';
    auxData := 0;
    sDataEnv := '';
    sDataRec := '';
    reaction_emoji := '';
    reaction_message_id := '';
    eh_arquivo := False;


    //gravar_log(Response);
    memResponse.Lines.Add('id: ' + Result.entry[0].id);


    if Assigned(Result.entry[0].changes[0]) then
    begin
      if Assigned(Result.entry[0].changes[0].value) then
      begin
        fromId := Result.entry[0].changes[0].value.metadata.display_phone_number;
        phone_number_id := Result.entry[0].changes[0].value.metadata.phone_number_id;
        memResponse.Lines.Add('display_phone_number: ' + fromId);
        memResponse.Lines.Add('phone_number_id: ' + phone_number_id);

        if Assigned(Result.entry[0].changes[0].value.statuses) then
        begin
          if Result.entry[0].changes[0].value.statuses[0].status <> '' then
          begin
            status := Result.entry[0].changes[0].value.statuses[0].status;
            recipient_id := Result.entry[0].changes[0].value.statuses[0].recipient_id;
            IdMensagem := Result.entry[0].changes[0].value.statuses[0].id;
            auxData := StrToIntDef(Result.entry[0].changes[0].value.statuses[0].timestamp,0);
            sDataEnv := FormatDateTime('DD/MM/YYYY hh:mm:ss', UnixToDateTime(auxData, False));
            sDataRec := FormatDateTime('DD/MM/YYYY hh:mm:ss', UnixToDateTime(auxData, False));

            memResponse.Lines.Add('recipient_id: ' + Result.entry[0].changes[0].value.statuses[0].recipient_id);
            memResponse.Lines.Add('IdMensagem: ' + Result.entry[0].changes[0].value.statuses[0].id);
            memResponse.Lines.Add('status: ' + Result.entry[0].changes[0].value.statuses[0].status + #13#10);
            memResponse.Lines.Add('Data Hora: ' + sDataEnv);

            if Assigned(Result.entry[0].changes[0].value.statuses[0].Errors ) then
            begin
              memResponse.Lines.Add('Message: ' + Result.entry[0].changes[0].value.statuses[0].Errors[0].Message);
              memResponse.Lines.Add('Code: ' + FLoatToStr(Result.entry[0].changes[0].value.statuses[0].Errors[0].code) );
              memResponse.Lines.Add('title: ' + Result.entry[0].changes[0].value.statuses[0].Errors[0].title);
              error_Message := Result.entry[0].changes[0].value.statuses[0].Errors[0].Message;
              error_Code := FLoatToStr(Result.entry[0].changes[0].value.statuses[0].Errors[0].code);
              error_title := Result.entry[0].changes[0].value.statuses[0].Errors[0].title;

              if Assigned(Result.entry[0].changes[0].value.statuses[0].Errors[0].error_data ) then
              begin
                memResponse.Lines.Add('details: ' + Result.entry[0].changes[0].value.statuses[0].Errors[0].error_data.details);
                error_data_details := Result.entry[0].changes[0].value.statuses[0].Errors[0].error_data.details;
              end;

            end;

            if status = 'failed' then
            begin
              memResponse.Lines.Add('Falhou o Envio recipient_id: ' + recipient_id + ' IdMensagem: ' + IdMensagem);
              if error_data_details = 'Message Undeliverable.' then
              begin
                wlo_ack := '-1';
                wlo_status := 'Número Inválido';
              end
              else
              begin
                wlo_ack := '0';
                wlo_status := 'Não Enviado';
              end;

              //SalvarStatusMessage_Local(recipient_id, '', '', IdMensagem, wlo_ack, wlo_status);
            end
            else
            begin
              if status = 'sent' then
              begin
                wlo_ack := '1';
                wlo_status := 'Enviada';
              end;
              if status = 'delivered' then
              begin
                wlo_ack := '2';
                wlo_status := 'Recebida';
              end;
              if status = 'read' then
              begin
                wlo_ack := '3';
                wlo_status := 'Visualizada';
              end;
            end;


            {if status = 'sent' then
              SalvarStatusMessage_Mult(recipient_id, '', '', IdMensagem, '1', 'Enviada', sDataEnv, sDataRec)
            else
            if status = 'delivered' then
              SalvarStatusMessage_Mult(recipient_id, '', '', IdMensagem, '2', 'Recebida', sDataEnv, sDataRec)
            else
            if status = 'read' then
              SalvarStatusMessage_Mult(recipient_id, '', '', IdMensagem, '3', 'Visualizada', sDataEnv, sDataRec);}


            Exit;
          end;
        end;

        if Assigned(Result.entry[0].changes[0].value.contacts) then
        begin
          if Result.entry[0].changes[0].value.contacts[0].wa_id <> '' then
          begin
            ChatId := Result.entry[0].changes[0].value.contacts[0].wa_id;
            profile_name := Result.entry[0].changes[0].value.contacts[0].profile.name;
            memResponse.Lines.Add('wa_id: ' + Result.entry[0].changes[0].value.contacts[0].wa_id);
            memResponse.Lines.Add('profile.name: ' + Result.entry[0].changes[0].value.contacts[0].profile.name);

          end;
        end;

        if Assigned(Result.entry[0].changes[0].value.messages) then
        begin
          if Assigned(Result.entry[0].changes[0].value.messages[0].reaction) then
          begin
            reaction_message_id := Result.entry[0].changes[0].value.messages[0].reaction.message_id;
            reaction_emoji := Result.entry[0].changes[0].value.messages[0].reaction.emoji;

            if reaction_emoji <> '' then
            begin

              memResponse.Lines.Add('reaction.emoji: ' + Result.entry[0].changes[0].value.messages[0].reaction.emoji);
              memResponse.Lines.Add('message_id: ' + Result.entry[0].changes[0].value.messages[0].reaction.message_id);

              //reaction_emoji := IntToStr(GetCodReacaoByEmoji(reaction_emoji));
              //Add_Reaction_msg_Retorno_Mult(ChatId, reaction_emoji, reaction_message_id);
              Exit;
            end;
          end;

          IdMensagem := Result.entry[0].changes[0].value.messages[0].id;
          S_Type := Result.entry[0].changes[0].value.messages[0].&type;


          memResponse.Lines.Add('Type: ' + Result.entry[0].changes[0].value.messages[0].&type);

          if Assigned(Result.entry[0].changes[0].value.messages[0].button) then
          begin
            memResponse.Lines.Add('Text: ' + Result.entry[0].changes[0].value.messages[0].button.Text);
          end;


          if Assigned(Result.entry[0].changes[0].value.messages[0].text) then
          begin
            if Result.entry[0].changes[0].value.messages[0].text.body <> '' then
            begin
              memResponse.Lines.Add('Body Text: ' + Result.entry[0].changes[0].value.messages[0].text.body);
              body := Result.entry[0].changes[0].value.messages[0].text.body;
            end;
          end;

          //Response Button Template payload
          try
            if Assigned(Result.entry[0].changes[0].value.messages[0].button) then
            begin
              if Result.entry[0].changes[0].value.messages[0].button.text <> '' then
              begin
                body := Result.entry[0].changes[0].value.messages[0].button.text;
                SelectButtonId := Result.entry[0].changes[0].value.messages[0].button.payload;

                memResponse.Lines.Add('Texto Botão: ' + Result.entry[0].changes[0].value.messages[0].button.text);
                memResponse.Lines.Add('ID Botão Payload: ' + Result.entry[0].changes[0].value.messages[0].button.payload);
              end;
            end;
          except on E: Exception do
          end;


          //Response Button
          try
            if Assigned(Result.entry[0].changes[0].value.messages[0].interactive.button_reply) then
            begin
              if Result.entry[0].changes[0].value.messages[0].interactive.button_reply.title <> '' then
              begin
                body := Result.entry[0].changes[0].value.messages[0].interactive.button_reply.title;
                SelectButtonId := Result.entry[0].changes[0].value.messages[0].interactive.button_reply.id;

                memResponse.Lines.Add('Texto Botão: ' + Result.entry[0].changes[0].value.messages[0].interactive.button_reply.title);
                memResponse.Lines.Add('ID Botão: ' + Result.entry[0].changes[0].value.messages[0].interactive.button_reply.id);
              end;
            end;
          except on E: Exception do
          end;

          //Response List
          try
            if Assigned(Result.entry[0].changes[0].value.messages[0].interactive.list_reply) then
            begin
              if Result.entry[0].changes[0].value.messages[0].interactive.list_reply.title <> '' then
              begin
                body := Result.entry[0].changes[0].value.messages[0].interactive.list_reply.title;
                SelectRowId := Result.entry[0].changes[0].value.messages[0].interactive.list_reply.id;
                description := Result.entry[0].changes[0].value.messages[0].interactive.list_reply.description;

                memResponse.Lines.Add('Description Lista: ' + Result.entry[0].changes[0].value.messages[0].interactive.list_reply.description);
                memResponse.Lines.Add('ID Lista: ' + Result.entry[0].changes[0].value.messages[0].interactive.list_reply.id);
                memResponse.Lines.Add('Title Lista: ' + Result.entry[0].changes[0].value.messages[0].interactive.list_reply.title);
              end;
            end;
          except on E: Exception do
          end;

          //Msg Origem
          if Assigned(Result.entry[0].changes[0].value.messages[0].context) then
          begin
            if Result.entry[0].changes[0].value.messages[0].context.id <> '' then
            begin
              idMensagemOrigem := Result.entry[0].changes[0].value.messages[0].context.id;

              memResponse.Lines.Add('id mensagem Origem: ' + Result.entry[0].changes[0].value.messages[0].context.id);
              S_Type_origem := '';
              //memResponse.Lines.Add('From mensagem Origem: ' + Result.entry[0].changes[0].value.messages[0].context.From);
            end;
          end;

          //Arquivo Imagem
          if Assigned(Result.entry[0].changes[0].value.messages[0].image) then
          begin
            if Result.entry[0].changes[0].value.messages[0].image.id <> '' then
            begin
              eh_arquivo := True;
              memResponse.Lines.Add('Image id: ' + Result.entry[0].changes[0].value.messages[0].image.id);
              memResponse.Lines.Add('Image MimeType: ' + Result.entry[0].changes[0].value.messages[0].image.mime_type);


              MimeType := Result.entry[0].changes[0].value.messages[0].image.mime_type;
              mediakey := Result.entry[0].changes[0].value.messages[0].image.SHA256;
              Extensao := WPPCloudAPI1.GetContentTypeFromExtension(MimeType);
              //Extensao := StringReplace(Extensao, 'image/', '', []);

              //Gerar o URL para Download
              sResponse := WPPCloudAPI1.DownloadMedia(Result.entry[0].changes[0].value.messages[0].image.id, Result.entry[0].changes[0].value.messages[0].image.mime_type);
              memResponse.Lines.Add('url: ' + sResponse);
              url := sResponse;
              clienturl := url;

              wlo_NomeArquivo := '';
              wlo_NomeArquivo := GerarGUID +  Extensao;
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'{', '',[]);
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'}', '',[]);
              FileName := ExtractFilePath(ParamStr(0)) + 'Temp\' + wlo_NomeArquivo;

              //Fazer o Download pelo URL
              sResponse := WPPCloudAPI1.DownloadMediaURL(url, MimeType, FileName);

              memResponse.Lines.Add(sResponse);
            end;
          end
          else
          if Assigned(Result.entry[0].changes[0].value.messages[0].audio) then
          begin
            if Result.entry[0].changes[0].value.messages[0].audio.id <> '' then
            begin
              eh_arquivo := True;
              memResponse.Lines.Add('audio id: ' + Result.entry[0].changes[0].value.messages[0].audio.id);
              memResponse.Lines.Add('audio MimeType: ' + Result.entry[0].changes[0].value.messages[0].audio.mime_type);
              MimeType := Result.entry[0].changes[0].value.messages[0].audio.mime_type;
              mediakey := Result.entry[0].changes[0].value.messages[0].audio.SHA256;
              Extensao := WPPCloudAPI1.GetContentTypeFromExtension(MimeType);
              //Extensao := StringReplace(Extensao, 'audio/', '', []);

              //Gerar o URL para Download
              sResponse := WPPCloudAPI1.DownloadMedia(Result.entry[0].changes[0].value.messages[0].audio.id, Result.entry[0].changes[0].value.messages[0].audio.mime_type);

              memResponse.Lines.Add('url: ' + sResponse);
              url := sResponse;
              clienturl := url;

              wlo_NomeArquivo := '';
              wlo_NomeArquivo := GerarGUID +  Extensao;
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'{', '',[]);
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'}', '',[]);
              FileName := ExtractFilePath(ParamStr(0)) + 'Temp\' + wlo_NomeArquivo;

              //Fazer o Download pelo URL
              sResponse := WPPCloudAPI1.DownloadMediaURL(url, MimeType, FileName);
              memResponse.Lines.Add(sResponse);
            end;
          end
          else
          if Assigned(Result.entry[0].changes[0].value.messages[0].video) then
          begin
            if Result.entry[0].changes[0].value.messages[0].video.id <> '' then
            begin
              eh_arquivo := True;
              memResponse.Lines.Add('video id: ' + Result.entry[0].changes[0].value.messages[0].video.id);
              memResponse.Lines.Add('video MimeType: ' + Result.entry[0].changes[0].value.messages[0].video.mime_type);

              MimeType := Result.entry[0].changes[0].value.messages[0].video.mime_type;
              mediakey := Result.entry[0].changes[0].value.messages[0].video.SHA256;
              Extensao := WPPCloudAPI1.GetContentTypeFromExtension(MimeType);
              //Extensao := StringReplace(Extensao, 'video/', '', []);

              //Gerar o URL para Download
              sResponse := WPPCloudAPI1.DownloadMedia(Result.entry[0].changes[0].value.messages[0].video.id, Result.entry[0].changes[0].value.messages[0].video.mime_type);
              memResponse.Lines.Add('url: ' + sResponse + #13#10);
              url := sResponse;
              clienturl := url;

              wlo_NomeArquivo := '';
              wlo_NomeArquivo := GerarGUID +  Extensao;
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'{', '',[]);
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'}', '',[]);
              FileName := ExtractFilePath(ParamStr(0)) + 'Temp\' + wlo_NomeArquivo;

              //Fazer o Download pelo URL
              sResponse := WPPCloudAPI1.DownloadMediaURL(url, MimeType, FileName);
              memResponse.Lines.Add(sResponse);
            end;
          end
          else
          if Assigned(Result.entry[0].changes[0].value.messages[0].document) then
          begin
            if Result.entry[0].changes[0].value.messages[0].document.id <> '' then
            begin
              eh_arquivo := True;
              memResponse.Lines.Add('document id: ' + Result.entry[0].changes[0].value.messages[0].document.id);
              memResponse.Lines.Add('document MimeType: ' + Result.entry[0].changes[0].value.messages[0].document.mime_type);

              MimeType := Result.entry[0].changes[0].value.messages[0].document.mime_type;
              mediakey := Result.entry[0].changes[0].value.messages[0].document.SHA256;
              Extensao := WPPCloudAPI1.GetContentTypeFromExtension(MimeType);
              //Extensao := StringReplace(Extensao, 'document/', '', []);

              //Gerar o URL para Download
              sResponse := WPPCloudAPI1.DownloadMedia(Result.entry[0].changes[0].value.messages[0].document.id, Result.entry[0].changes[0].value.messages[0].document.mime_type);

              memResponse.Lines.Add('url: ' + sResponse);
              url := sResponse;
              clienturl := url;

              wlo_NomeArquivo := '';
              wlo_NomeArquivo := GerarGUID +  Extensao;
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'{', '',[]);
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'}', '',[]);
              FileName := ExtractFilePath(ParamStr(0)) + 'Temp\' + wlo_NomeArquivo;

              //Fazer o Download pelo URL
              sResponse := WPPCloudAPI1.DownloadMediaURL(url, MimeType, FileName);
              memResponse.Lines.Add(sResponse);
            end;
          end
          else
          if Assigned(Result.entry[0].changes[0].value.messages[0].sticker) then
          begin
            if Result.entry[0].changes[0].value.messages[0].sticker.id <> '' then
            begin
              eh_arquivo := True;

              memResponse.Lines.Add('sticker id: ' + Result.entry[0].changes[0].value.messages[0].sticker.id);
              memResponse.Lines.Add('sticker MimeType: ' + Result.entry[0].changes[0].value.messages[0].sticker.mime_type);

              MimeType := Result.entry[0].changes[0].value.messages[0].sticker.mime_type;
              mediakey := Result.entry[0].changes[0].value.messages[0].sticker.SHA256;
              Extensao := WPPCloudAPI1.GetContentTypeFromExtension(MimeType);
              //Extensao := StringReplace(Extensao, 'sticker/', '', []);

              //Gerar o URL para Download
              sResponse := WPPCloudAPI1.DownloadMedia(Result.entry[0].changes[0].value.messages[0].sticker.id, Result.entry[0].changes[0].value.messages[0].sticker.mime_type);


              memResponse.Lines.Add('url: ' + sResponse);
              url := sResponse;
              clienturl := url;

              wlo_NomeArquivo := '';
              wlo_NomeArquivo := GerarGUID +  Extensao;
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'{', '',[]);
              wlo_NomeArquivo := StringReplace(wlo_NomeArquivo,'}', '',[]);
              FileName := ExtractFilePath(ParamStr(0)) + 'Temp\' + wlo_NomeArquivo;

              //Fazer o Download pelo URL
              sResponse := WPPCloudAPI1.DownloadMediaURL(url, MimeType, FileName);


              memResponse.Lines.Add(sResponse);
            end;
          end;

          {ProcessaMsgNaoLida(ChatId, fromId, IdMensagem, SelectButtonId, SelectRowId, profile_name, Body, S_Caption, Title, Footer,
            description, FileName, S_TYPE, eh_arquivo, mediakey, clienturl, mimetype, '', IdMensagemOrigem, quotedMsg_caption,
            quotedMsg_body, S_Type_origem, 0, phone_number_id);}


        end;
      end;
    end;

  except
    on E: Exception do
    begin
      memResponse.Lines.Add('Response Webhook' + e.Message);
    end;
  end;

end;

procedure TfrmPrincipal.WPPCloudAPI1RetSendMessage(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add(Response);
end;

end.
