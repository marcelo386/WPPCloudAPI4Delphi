unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, uWPPCloudAPI;

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
  private
    { Private declarations }
  public
    { Public declarations }
    sResponse: string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

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
      '          "title": "N�O" ' +
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
    ShowMessage('Informe o N�mero do WhatsApp');
    ed_num.Setfocus;
    Exit;
  end;

  if mem_message.Text = '' then
  begin
    ShowMessage('Informe o N�mero do WhatsApp que deseja Compartilhar');
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
      '{"type":"button","sub_type":"quick_reply","index":1,"parameters":[{"type":"text","text":"N�O"}]} ]}}';


  WPPCloudAPI1.TokenApiOficial := edtTokenAPI.Text;
  WPPCloudAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  sResponse := WPPCloudAPI1.Send_Template(jsonTemplate);

  memResponse.Lines.Add(sResponse);
end;

end.