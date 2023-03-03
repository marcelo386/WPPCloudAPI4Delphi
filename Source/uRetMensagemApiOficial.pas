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
unit uRetMensagemApiOficial;


interface

uses
  System.SysUtils, System.Classes, System.JSON, Generics.Collections, Rest.Json;

type
  TContact = class
  private
    FInput: string;
    FWaID: string;
  public
    property Input: string read FInput write FInput;
    property WaID: string read FWaID write FWaID;
  end;

  TMessage = class
  private
    FID: string;
  public
    property ID: string read FID write FID;
  end;

  TImages = class
  private
    FID: string;
  public
    property ID: string read FID write FID;
  end;

  TMessagePayload = class
  private
    FMessagingProduct: string;
    FContacts: TArray<TContact>;
    FMessages: TArray<TMessage>;
    FImage: TArray<TImages>;
  public
    property MessagingProduct: string            read FMessagingProduct  write FMessagingProduct;
    property Contacts:         TArray<TContact>  read FContacts          write FContacts;
    property Messages:         TArray<TMessage>  read FMessages          write FMessages;
    property Image:            TArray<TImages>    read FImage             write FImage;

    function ToJSON: string;
    class function FromJSON(const AJSON: string): TMessagePayload;
  end;

implementation

{ TMessagePayload }

class function TMessagePayload.FromJSON(const AJSON: string): TMessagePayload;
begin
  Result := TJson.JsonToObject<TMessagePayload>(AJSON);
end;

function TMessagePayload.ToJSON: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.

