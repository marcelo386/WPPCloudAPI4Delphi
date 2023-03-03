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
unit uWhatsAppBusinessClasses;

interface

uses
  System.Generics.Collections, System.JSON, Rest.Json;

type

TButtonClass = class
private
  FPayload: String;
  FText: String;
public
  property payload: String read FPayload write FPayload;
  property text: String read FText write FText;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TButtonClass;
end;

TTextClass = class
private
  FBody: string;
public
  property Body: string read FBody write FBody;
end;

TStickerClass = class
private
  FMimeType: string;
  FSha256: string;
  FId: string;
  FAnimated: Boolean;
public
  property MimeType: string read FMimeType write FMimeType;
  property Sha256: string read FSha256 write FSha256;
  property Id: string read FId write FId;
  property Animated: Boolean read FAnimated write FAnimated;
end;

TAudioClass = class
private
  FMimeType: string;
  FSHA256: string;
  FId: string;
  FVoice: Boolean;
public
  property MimeType: string read FMimeType write FMimeType;
  property SHA256: string read FSHA256 write FSHA256;
  property Id: string read FId write FId;
  property Voice: Boolean read FVoice write FVoice;
end;

TImageClass = class
private
  FMimeType: string;
  FSHA256: string;
  FId: string;
public
  property MimeType: string read FMimeType write FMimeType;
  property SHA256: string read FSHA256 write FSHA256;
  property Id: string read FId write FId;
end;

TDocumentClass = class
private
  FFileName: string;
  FMimeType: string;
  FSHA256: string;
  FID: string;
public
  property FileName: string read FFileName write FFileName;
  property MimeType: string read FMimeType write FMimeType;
  property SHA256: string read FSHA256 write FSHA256;
  property ID: string read FID write FID;
end;

TVideoClass = class
private
  FMimeType: string;
  FSHA256: string;
  FID: string;
public
  property MimeType: string read FMimeType write FMimeType;
  property SHA256: string read FSHA256 write FSHA256;
  property ID: string read FID write FID;
end;



TContextClass = class
private
  FFrom: String;
  FId: String;
public
  property from: String read FFrom write FFrom;
  property id: String read FId write FId;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TContextClass;
end;

TMessagesClass = class
private
  FButton: TButtonClass;
  FText: TTextClass;
  FContext: TContextClass;
  FFrom: String;
  FId: String;
  FTimestamp: String;
  FType: String;
  FImage: TImageClass;
  FAudio: TAudioClass;
  FVideo: TVideoClass;
  FDocument: TDocumentClass;
  FSticker: TStickerClass;
public
  property button: TButtonClass read FButton write FButton;
  property text: TTextClass read FText write FText;
  property image: TImageClass read FImage write FImage;
  property audio: TAudioClass read FAudio write FAudio;
  property video: TVideoClass read FVideo write FVideo;
  property sticker: TStickerClass read FSticker write FSticker;
  property document: TDocumentClass read FDocument write FDocument;
  property context: TContextClass read FContext write FContext;
  property from: String read FFrom write FFrom;
  property id: String read FId write FId;
  property timestamp: String read FTimestamp write FTimestamp;
  property &type: String read FType write FType;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TMessagesClass;
end;

TProfileClass = class
private
  FName: String;
public
  property name: String read FName write FName;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TProfileClass;
end;

TContactsClass = class
private
  FProfile: TProfileClass;
  FWa_id: String;
public
  property profile: TProfileClass read FProfile write FProfile;
  property wa_id: String read FWa_id write FWa_id;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TContactsClass;
end;

TMetadataClass = class
private
  FDisplay_phone_number: String;
  FPhone_number_id: String;
public
  property display_phone_number: String read FDisplay_phone_number write FDisplay_phone_number;
  property phone_number_id: String read FPhone_number_id write FPhone_number_id;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TMetadataClass;
end;

TValueClass = class
private
  FContacts: TArray<TContactsClass>;
  FMessages: TArray<TMessagesClass>;
  FMessaging_product: String;
  FMetadata: TMetadataClass;
public
  property contacts: TArray<TContactsClass> read FContacts write FContacts;
  property messages: TArray<TMessagesClass> read FMessages write FMessages;
  property messaging_product: String read FMessaging_product write FMessaging_product;
  property metadata: TMetadataClass read FMetadata write FMetadata;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TValueClass;
end;

TChangesClass = class
private
  FField: String;
  FValue: TValueClass;
public
  property field: String read FField write FField;
  property value: TValueClass read FValue write FValue;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TChangesClass;
end;

TEntryClass = class
private
  FChanges: TArray<TChangesClass>;
  FId: String;
public
  property changes: TArray<TChangesClass> read FChanges write FChanges;
  property id: String read FId write FId;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TEntryClass;
end;

TResultClass = class
private
  FEntry: TArray<TEntryClass>;
  FObject: String;
public
  property entry: TArray<TEntryClass> read FEntry write FEntry;
  property &object: String read FObject write FObject;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TResultClass;
end;

implementation

{TButtonClass}


function TButtonClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TButtonClass.FromJsonString(AJsonString: string): TButtonClass;
begin
  result := TJson.JsonToObject<TButtonClass>(AJsonString)
end;

{TContextClass}


function TContextClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TContextClass.FromJsonString(AJsonString: string): TContextClass;
begin
  result := TJson.JsonToObject<TContextClass>(AJsonString)
end;

{TMessagesClass}

constructor TMessagesClass.Create;
begin
  inherited;
  FContext := TContextClass.Create();
  FButton := TButtonClass.Create();
end;

destructor TMessagesClass.Destroy;
begin
  FContext.free;
  FButton.free;
  inherited;
end;

function TMessagesClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMessagesClass.FromJsonString(AJsonString: string): TMessagesClass;
begin
  result := TJson.JsonToObject<TMessagesClass>(AJsonString)
end;

{TProfileClass}


function TProfileClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TProfileClass.FromJsonString(AJsonString: string): TProfileClass;
begin
  result := TJson.JsonToObject<TProfileClass>(AJsonString)
end;

{TContactsClass}

constructor TContactsClass.Create;
begin
  inherited;
  FProfile := TProfileClass.Create();
end;

destructor TContactsClass.Destroy;
begin
  FProfile.free;
  inherited;
end;

function TContactsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TContactsClass.FromJsonString(AJsonString: string): TContactsClass;
begin
  result := TJson.JsonToObject<TContactsClass>(AJsonString)
end;

{TMetadataClass}


function TMetadataClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMetadataClass.FromJsonString(AJsonString: string): TMetadataClass;
begin
  result := TJson.JsonToObject<TMetadataClass>(AJsonString)
end;

{TValueClass}

constructor TValueClass.Create;
begin
  inherited;
  FMetadata := TMetadataClass.Create();
end;

destructor TValueClass.Destroy;
var
  LcontactsItem: TContactsClass;
  LmessagesItem: TMessagesClass;
begin

 for LcontactsItem in FContacts do
   LcontactsItem.free;
 for LmessagesItem in FMessages do
   LmessagesItem.free;

  FMetadata.free;
  inherited;
end;

function TValueClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TValueClass.FromJsonString(AJsonString: string): TValueClass;
begin
  result := TJson.JsonToObject<TValueClass>(AJsonString)
end;

{TChangesClass}

constructor TChangesClass.Create;
begin
  inherited;
  FValue := TValueClass.Create();
end;

destructor TChangesClass.Destroy;
begin
  FValue.free;
  inherited;
end;

function TChangesClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TChangesClass.FromJsonString(AJsonString: string): TChangesClass;
begin
  result := TJson.JsonToObject<TChangesClass>(AJsonString)
end;

{TEntryClass}

destructor TEntryClass.Destroy;
var
  LchangesItem: TChangesClass;
begin

 for LchangesItem in FChanges do
   LchangesItem.free;

  inherited;
end;

function TEntryClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEntryClass.FromJsonString(AJsonString: string): TEntryClass;
begin
  result := TJson.JsonToObject<TEntryClass>(AJsonString)
end;

{TResultClass}

destructor TResultClass.Destroy;
var
  LentryItem: TEntryClass;
begin

 for LentryItem in FEntry do
   LentryItem.free;

  inherited;
end;

function TResultClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultClass.FromJsonString(AJsonString: string): TResultClass;
begin
  result := TJson.JsonToObject<TResultClass>(AJsonString)
end;

end.


(*type
  TWhatsAppBusinessAccountMetadata = class
  private
    FDisplayPhoneNumber: string;
    FPhoneNumberId: string;
  public
    property DisplayPhoneNumber: string read FDisplayPhoneNumber write FDisplayPhoneNumber;
    property PhoneNumberId: string read FPhoneNumberId write FPhoneNumberId;
  end;

  TWhatsAppBusinessAccountProfile = class
  private
    FName: string;
  public
    property Name: string read FName write FName;
  end;

  TWhatsAppBusinessAccountContact = class
  private
    FProfile: TWhatsAppBusinessAccountProfile;
    FWAId: string;
  public
    //constructor Create;
    //destructor Destroy; override;
    property Profile: TWhatsAppBusinessAccountProfile read FProfile;
    property WAId: string read FWAId write FWAId;
  end;

  TWhatsAppBusinessAccountButton = class
  private
    FPayload: string;
    FText: string;
  public
    property Payload: string read FPayload write FPayload;
    property Text: string read FText write FText;
  end;

  TWhatsAppBusinessAccountMessageContext = class
  private
    FFrom: string;
    FId: string;
  public
    property From: string read FFrom write FFrom;
    property Id: string read FId write FId;
  end;

  TWhatsAppBusinessAccountMessageButton = class
  private
    FContext: TWhatsAppBusinessAccountMessageContext;
    FFrom: string;
    FId: string;
    FTimestamp: string;
    FType: string;
    FButton: TWhatsAppBusinessAccountButton;
  public
    //constructor Create;
    //destructor Destroy; override;
    property Context: TWhatsAppBusinessAccountMessageContext read FContext;
    property From: string read FFrom write FFrom;
    property Id: string read FId write FId;
    property Timestamp: string read FTimestamp write FTimestamp;
    property MessageType: string read FType write FType;
    property Button: TWhatsAppBusinessAccountButton read FButton;
  end;

  TWhatsAppMessageText = class
  private
    FBody: string;
  public
    property Body: string read FBody write FBody;
  end;

  TWhatsAppSticker = class
  private
    FMimeType: string;
    FSha256: string;
    FId: string;
    FAnimated: Boolean;
  public
    property MimeType: string read FMimeType write FMimeType;
    property Sha256: string read FSha256 write FSha256;
    property Id: string read FId write FId;
    property Animated: Boolean read FAnimated write FAnimated;
  end;

  TWhatsAppAudio = class
  private
    FMimeType: string;
    FSHA256: string;
    FId: string;
    FVoice: Boolean;
  public
    property MimeType: string read FMimeType write FMimeType;
    property SHA256: string read FSHA256 write FSHA256;
    property Id: string read FId write FId;
    property Voice: Boolean read FVoice write FVoice;
  end;

  TWhatsAppImage = class
  private
    FMimeType: string;
    FSHA256: string;
    FId: string;
  public
    property MimeType: string read FMimeType write FMimeType;
    property SHA256: string read FSHA256 write FSHA256;
    property Id: string read FId write FId;
  end;

  TWhatsAppDocument = class
  private
    FFileName: string;
    FMimeType: string;
    FSHA256: string;
    FID: string;
  public
    property FileName: string read FFileName write FFileName;
    property MimeType: string read FMimeType write FMimeType;
    property SHA256: string read FSHA256 write FSHA256;
    property ID: string read FID write FID;
  end;

  TWhatsAppVideo = class
  private
    FMimeType: string;
    FSHA256: string;
    FID: string;
  public
    property MimeType: string read FMimeType write FMimeType;
    property SHA256: string read FSHA256 write FSHA256;
    property ID: string read FID write FID;
  end;

  TWhatsAppBusinessAccountMessage = class
  private
    FContext: TWhatsAppBusinessAccountMessageContext;
    FFrom: string;
    FId: string;
    FTimestamp: string;
    FType: string;
    FButton: TWhatsAppBusinessAccountButton;
    FText: TWhatsAppMessageText;
    FImage: TWhatsAppImage;
    FAudio: TWhatsAppAudio;
    FDocument: TWhatsAppDocument;
    FVideo: TWhatsAppVideo;
    FSticker: TWhatsAppSticker;
    function GetIsAudio: Boolean;
    function GetIsDocument: Boolean;
    function GetIsVideo: Boolean;
    function GetIsImage: Boolean;
    function GetIsSticker: Boolean;

  public
    constructor Create;
    destructor Destroy; override;
    property Context: TWhatsAppBusinessAccountMessageContext read FContext;
    property From: string read FFrom write FFrom;
    property Id: string read FId write FId;
    property Timestamp: string read FTimestamp write FTimestamp;
    property MessageType: string read FType write FType;
    property Button: TWhatsAppBusinessAccountButton read FButton;
    property Text: TWhatsAppMessageText read FText;
    property Image: TWhatsAppImage read FImage;
    property Audio: TWhatsAppAudio read FAudio;
    property Document: TWhatsAppDocument read FDocument;
    property Video: TWhatsAppVideo read FVideo;
    property Sticker: TWhatsAppSticker read FSticker write FSticker;
    property IsDocument: Boolean read GetIsDocument;
    property IsAudio: Boolean read GetIsAudio;
    property IsVideo: Boolean read GetIsVideo;
    property IsImage: Boolean read GetIsImage;
    property IsSticker: Boolean read GetIsSticker;
  end;

  TWhatsAppBusinessAccountChange = class
  private
    FValue: TDictionary<string, Variant>;
    FField: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Value: TDictionary<string, Variant> read FValue;
    property Field: string read FField write FField;
  end;

  TWhatsAppBusinessAccountEntry = class
  private
    FId: string;
    FChanges: TObjectList<TWhatsAppBusinessAccountChange>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: string read FId write FId;
    property Changes: TObjectList<TWhatsAppBusinessAccountChange> read FChanges;
  end;

  TWhatsAppBusinessAccount = class
  private
    FObject: string;
    FEntry: TObjectList<TWhatsAppBusinessAccountEntry>;
  public
    constructor Create;
    destructor Destroy; override;
    property &Object: string read FObject write FObject;
    property Entry: TObjectList<TWhatsAppBusinessAccountEntry> read FEntry;
    function ToJSON: string;
    class function FromJSON(const AJSON: string): TWhatsAppBusinessAccount;
  end;

implementation

{ TWhatsAppBusinessAccount }

constructor TWhatsAppBusinessAccount.Create;
begin
  FEntry := TObjectList<TWhatsAppBusinessAccountEntry>.Create;
end;

destructor TWhatsAppBusinessAccount.Destroy;
begin
  FEntry.Free;
  inherited;
end;

class function TWhatsAppBusinessAccount.FromJSON(const AJSON: string): TWhatsAppBusinessAccount;
begin
  Result := TJson.JsonToObject<TWhatsAppBusinessAccount>(AJSON);
end;

function TWhatsAppBusinessAccount.ToJSON: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

{ TWhatsAppBusinessAccountEntry }

constructor TWhatsAppBusinessAccountEntry.Create;
begin
  FChanges := TObjectList<TWhatsAppBusinessAccountChange>.Create;
end;

destructor TWhatsAppBusinessAccountEntry.Destroy;
begin
  FChanges.Free;
  inherited;
end;

{ TWhatsAppBusinessAccountChange }

constructor TWhatsAppBusinessAccountChange.Create;
begin
  FValue := TDictionary<string, Variant>.Create;
end;

destructor TWhatsAppBusinessAccountChange.Destroy;
begin
  FValue.Free;
  inherited;
end;

{ TWhatsAppBusinessAccountMessage }

constructor TWhatsAppBusinessAccountMessage.Create;
begin

end;

destructor TWhatsAppBusinessAccountMessage.Destroy;
begin

  inherited;
end;

function TWhatsAppBusinessAccountMessage.GetIsAudio: Boolean;
begin
  Result := FType = 'audio';
end;

function TWhatsAppBusinessAccountMessage.GetIsDocument: Boolean;
begin
  Result := FType =  'document';
end;

function TWhatsAppBusinessAccountMessage.GetIsImage: Boolean;
begin
  Result := FType =  'image';
end;

function TWhatsAppBusinessAccountMessage.GetIsVideo: Boolean;
begin
  Result := FType =  'video';
end;

function TWhatsAppBusinessAccountMessage.GetIsSticker: Boolean;
begin
  Result := FType =  'sticker';
end;

end.
*)