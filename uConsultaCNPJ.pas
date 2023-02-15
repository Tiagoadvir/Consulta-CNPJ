unit uConsultaCNPJ;

interface

uses
  RESTRequest4D,
  uFancyDialog,
  uFormat,
  uFunctions,

  DataSet.Serialize,
  DataSet.Serialize.Config,

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Forms,
  FMX.Graphics,
  FMX.StdCtrls,
  FMX.Types,

  FireDAC.Comp.Client,

  System.Classes,
  System.DateUtils,
  System.JSON,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TFrmPrincipal = class(TForm)
    edtCNPJ: TEdit;
    lblTItulo: TLabel;
    lblCNPJ: TLabel;
    btnCOnultar: TButton;
    lblnome: TLabel;
    lblporte: TLabel;
    lblSituacao: TLabel;
    lbllogradouro: TLabel;
    lblnumero: TLabel;
    lbltipo: TLabel;
    lblmunicipio: TLabel;
    lblbairro: TLabel;
    lblUf: TLabel;
    lblCEP: TLabel;
    lblfantasia: TLabel;
    lbltelefone: TLabel;
    lblMotivodaSituacao: TLabel;
    lblnaturezjuridica: TLabel;
    lblAbertura: TLabel;
    lblDataSituacao: TLabel;
    lblUltimaAtualizacao: TLabel;
    lblSituacao1: TLabel;
    lblmotivodasituacao1: TLabel;
    lblnome1: TLabel;
    lbltipo1: TLabel;
    lblporte1: TLabel;
    lbllogradouro1: TLabel;
    lblnumero1: TLabel;
    lblbairro1: TLabel;
    lblmunicipio1: TLabel;
    lblUf1: TLabel;
    lblCEP1: TLabel;
    lblfantasia1: TLabel;
    lbltelefone1: TLabel;
    lblnaturezjuridica1: TLabel;
    lblAbertura1: TLabel;
    lblDataSituacao1: TLabel;
    lblUltimaAtualizacao1: TLabel;
    lblAtividadePrincipal: TLabel;
    lblAtividadePrincipal1: TLabel;
    procedure btnCOnultarClick(Sender: TObject);
    procedure edtCNPJTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigSerialize;
    procedure ConsultaCNPJ(CNPJ: String);
    function FormataData(dt: String): string;
    procedure LimpraLabels;
    { Private declarations }
  public
    { Public declarations }
    Fancy : TFancyDialog;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.btnCOnultarClick(Sender: TObject);
begin
         LimpraLabels;
         ConsultaCNPJ(SomenteNumero(edtCNPJ.Text));
end;


procedure TFrmPrincipal.ConfigSerialize;
begin
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
    TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TFrmPrincipal.ConsultaCNPJ(CNPJ: String);
 var
  LResponse : IResponse;
  TabCNPJ : TFDMemTable;
  Atividade : TJSONObject;
  i : Integer;
begin
   TabCNPJ := TFDMemTable.Create(nil);
   LResponse  := TRequest.New.BaseURL('https://www.receitaws.com.br/v1/cnpj/')
                 .Resource(CNPJ)
                 .Accept('Application/Json')
                 .DataSetAdapter(TabCNPJ)
                 .Get;

   if LResponse.StatusCode <> 200 then
   begin
      Fancy.Show(TIconDialog.Error,'CNPJ não encontrado', 'Ok');
     Exit
   end;


    with TabCNPJ do
    begin
       try
         lblSituacao1.Text :=  FieldByName('situacao').AsString;
         lblmotivodasituacao1.Text :=  FieldByName('motivo_situacao').AsString;
         lblnome1.text :=  FieldByName('nome').AsString;
         lbltipo1.Text :=  FieldByName('tipo').AsString;
         lblporte1.Text := FieldByName('porte').AsString;
         lbllogradouro1.text :=  FieldByName('logradouro').AsString;
         lblnumero1.Text := FieldByName('numero').AsString;
         lblbairro1.Text := FieldByName('bairro').AsString;
         lblmunicipio1.text := FieldByName('municipio').AsString;
         lbluf1.Text :=  FieldByName('uf').AsString;
         lblCEP1.text :=  FieldByName('cep').AsString;
         lblfantasia1.text := FieldByName('fantasia').AsString;
         lbltelefone1.text := FieldByName('telefone').AsString;
         lblnaturezjuridica1.text :=  FieldByName('numero').AsString;
         lblAbertura1.Text :=  FieldByName('abertura').AsString;
         lblDataSituacao1.Text :=  FieldByName('data_situacao').AsString;
         lblUltimaAtualizacao1.Text :=  FormataData(FieldByName('ultima_atualizacao').AsString);
       finally
         FreeAndNil(TabCNPJ);
       end;
    end;


end;




procedure TFrmPrincipal.edtCNPJTyping(Sender: TObject);
begin
    Formatar(edtCNPJ, CNPJ);
end;

//Formato: 2022-12-19T14:11:28.8777Z  ---> 2022-12-19 11:28:59
function TFrmPrincipal.FormataData (dt : String) : string;
begin
  Result := copy(dt, 1,10)+' '+copy(dt, 12,8); //+'/'+copy(dt,1,4)+' '+copy(dt, 12 ,5);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Fancy := TFancyDialog.Create(FrmPrincipal);
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Fancy);
end;

procedure TFrmPrincipal.LimpraLabels;
begin
         lblSituacao1.Text := EmptyStr;
         lblMotivodaSituacao1.Text := EmptyStr ;
         lblnome.text :=  lblnome.text ;
         lbltipo.Text := lbltipo.text;
         lblporte.Text := lblporte.text ;
         lbllogradouro.text := lbllogradouro.Text ;
         lblnumero.Text := lblnumero.Text ;
         lblbairro.Text := lblbairro.Text ;
         lblmunicipio.text := lblmunicipio.text;
         lbluf.Text := lbluf.Text;
         lblCEP.text := lblCEP.Text ;
         lblfantasia.text := lblfantasia.Text;
         lbltelefone.text := lbltelefone.text;
         lblnaturezjuridica.text := lblnaturezjuridica.Text;
         lblAbertura.Text := lblAbertura.Text;
         lblDataSituacao.Text := lblDataSituacao.Text;
         lblUltimaAtualizacao.Text := lblUltimaAtualizacao.Text;
end;


end.
