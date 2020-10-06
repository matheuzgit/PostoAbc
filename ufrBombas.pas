unit ufrBombas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Mask, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TFrmBombas = class(TForm)
    Panel1: TPanel;
    Bomba1: TPanel;
    Bomba2: TPanel;
    Bomba3: TPanel;
    Boma4: TPanel;
    BtnBomba1: TButton;
    MemoNotab1: TMemo;
    MemoNotab2: TMemo;
    BtnAbastecerB2: TButton;
    MemoNotab3: TMemo;
    BtnAbastecerB3: TButton;
    MemoNotab4: TMemo;
    BtnAbastecerB4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    QryBomba: TFDQuery;
    MaskB1: TMaskEdit;
    EdtB1: TEdit;
    MaskB2: TMaskEdit;
    EdtB2: TEdit;
    MaskB3: TMaskEdit;
    EdtB3: TEdit;
    MaskB4: TMaskEdit;
    EdtB4: TEdit;
    QryTanque: TFDQuery;
    QryAbastecimento: TFDQuery;
    EdtBomba1: TEdit;
    EdtBomba2: TEdit;
    EdtBomba3: TEdit;
    EdtBomba4: TEdit;
    Label10: TLabel;
    Label13: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    QryBombaBOMBA: TStringField;
    QryBombaID_TANQUE: TStringField;
    QryBombaIMPOSTO: TSingleField;
    QryBombaVALOR_LITRO: TSingleField;
    QryAbastecimentoID_TANQUE: TStringField;
    QryAbastecimentoDATAHORA: TSQLTimeStampField;
    QryAbastecimentoVALOR_PAGO: TSingleField;
    QryAbastecimentoQUANTIDADE: TSingleField;
    QryAbastecimentoIMPOSTO_PAGO: TSingleField;
    QryAbastecimentoBOMBA: TStringField;
    QryVolumeTanque: TFDQuery;
    QryTanqueID_TANQUE: TStringField;
    QryTanqueTIPO_COMBUSTIVEL: TStringField;
    QryTanqueLITROS: TSingleField;
    procedure BtnBomba1Click(Sender: TObject);
    procedure BtnAbastecerB2Click(Sender: TObject);
    procedure BtnAbastecerB3Click(Sender: TObject);
    procedure BtnAbastecerB4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     imposto , percentual,valorpago, volumetanque, valorBomba, mlgasolina, abastecido : currency;
     bomba ,data, bombacad : string;

  end;

var
  FrmBombas: TFrmBombas;

implementation

{$R *.dfm}

uses ufrPrincipal, UDados;

procedure TFrmBombas.BtnAbastecerB2Click(Sender: TObject);
begin
  bomba := 'BOMBA2';
  QryBomba.Close;
  QryBomba.Params.ParamByName('BOMBA').Value := bomba;
  QryBomba.open;

  QryTanque.SQL.Clear;
  QryTanque.SQL.Add('SELECT * FROM TBTANQUE WHERE ID_TANQUE =''' + QryBombaID_TANQUE.AsString+'''' );
  QryTanque.close;
  QryTanque.Open;


  volumetanque :=  QryTanqueLITROS.AsFloat;

  if volumetanque <= 0 then
    raise Exception.Create('Tanque de combustível vazio');

  if  QryBombaBOMBA.AsString = EmptyStr then
    raise Exception.Create('Bomba não cadastrada');

  abastecido := 0;

  mlgasolina := 0.100;

  imposto := StrToCurr(copy(MaskB2.Text,4,4));

  percentual := QryBombaIMPOSTO.AsCurrency;

  percentual := percentual/100;

  imposto := imposto * percentual;


  valorpago :=  StrToCurr(copy(MaskB2.Text,4,4));

  valorBomba := QryBombaVALOR_LITRO.AsCurrency/10;

  while  valorpago > valorBomba do
  begin
    mlgasolina := mlgasolina + 0.100;

    valorpago := valorpago - valorBomba;
  end;
  EdtB2.Text := CurrToStr(mlgasolina * 1000);

  MemoNotab2.Clear;

  data := ( FormatDateTime('dd.mm.yyyy hh:MM:ss', Now));

  MemoNotab2.Lines.Add('Valor Pago : ' + MaskB2.Text);
  MemoNotab2.Lines.Add('Imposto encima do valor pago: ' + CurrToStr(imposto));
  MemoNotab2.Lines.Add('Quantidade Abastecida: '+ EdtB2.Text +'Ml/Lt');
  MemoNotab2.Lines.Add('Data/Horário: ' + data);

  QryAbastecimento.SQL.Clear;
  QryAbastecimento.SQL.Add('INSERT INTO  TBABASTECIMENTO(BOMBA, ID_TANQUE, DATAHORA , VALOR_PAGO, QUANTIDADE, IMPOSTO_PAGO)'+
                    'VALUES(:BOMBA, :ID_TANQUE, :DATAHORA , :VALOR_PAGO, :QUANTIDADE, :IMPOSTO_PAGO)');

  QryAbastecimento.Params.ParamByName('BOMBA').AsString := bomba;
  QryAbastecimento.Params.ParamByName('ID_TANQUE').AsString := QryBombaID_TANQUE.AsString;
  QryAbastecimento.Params.ParamByName('DATAHORA').AsString := data;
  QryAbastecimento.Params.ParamByName('VALOR_PAGO').AsCurrency  := StrToCurr(copy(MaskB2.Text,4,4));
  QryAbastecimento.Params.ParamByName('QUANTIDADE').AsCurrency  :=  StrToCurr(EdtB2.Text);
  QryAbastecimento.Params.ParamByName('IMPOSTO_PAGO').AsCurrency  := imposto;
  QryAbastecimento.ExecSQL;
  MessageDlg('Abastecimento finalizado', mtInformation, [mbOK], 0);


  volumetanque := volumetanque -  StrToCurr(EdtB2.Text);

  QryVolumeTanque.SQL.Clear;
  QryVolumeTanque.SQL.Add('UPDATE  TBTANQUE SET LITROS =  '+ CurrToStr(volumetanque));
  QryVolumeTanque.SQL.Add('where ID_TANQUE = '''+QryBombaID_TANQUE.AsString+'''');
  QryVolumeTanque.ExecSQL;
end;

procedure TFrmBombas.BtnAbastecerB3Click(Sender: TObject);
begin
  bomba := 'BOMBA3';
  QryBomba.Close;
  QryBomba.Params.ParamByName('BOMBA').Value := bomba;
  QryBomba.open;

  QryTanque.SQL.Clear;
  QryTanque.SQL.Add('SELECT * FROM TBTANQUE WHERE ID_TANQUE =''' + QryBombaID_TANQUE.AsString+'''' );
  QryTanque.close;
  QryTanque.Open;


  volumetanque :=  QryTanqueLITROS.AsFloat;

  if volumetanque <= 0 then
    raise Exception.Create('Tanque de combustível vazio');

  if  QryBombaBOMBA.AsString = EmptyStr then
    raise Exception.Create('Bomba não cadastrada');


  abastecido := 0;

  mlgasolina := 0.100;

  imposto := StrToCurr(copy(MaskB3.Text,4,4));

  percentual := QryBombaIMPOSTO.AsCurrency;

  percentual := percentual/100;

  imposto := imposto * percentual;

  valorpago :=  StrToCurr(copy(MaskB3.Text,4,4));

  valorBomba := QryBombaVALOR_LITRO.AsCurrency/10;

  while  valorpago > valorBomba do
  begin
    mlgasolina := mlgasolina + 0.100;

    valorpago := valorpago - valorBomba;
  end;
  EdtB3.Text := CurrToStr(mlgasolina * 1000);

  MemoNotab3.Clear;

  data := ( FormatDateTime('dd.mm.yyyy hh:MM:ss', Now));

  MemoNotab3.Lines.Add('Valor Pago : ' + MaskB3.Text);
  MemoNotab3.Lines.Add('Imposto encima do valor pago: ' + CurrToStr(imposto));
  MemoNotab3.Lines.Add('Quantidade Abastecida: '+ EdtB3.Text +'Ml/Lt');
  MemoNotab3.Lines.Add('Data/Horário: ' + data);

  QryAbastecimento.SQL.Clear;
  QryAbastecimento.SQL.Add('INSERT INTO  TBABASTECIMENTO(BOMBA, ID_TANQUE, DATAHORA , VALOR_PAGO, QUANTIDADE, IMPOSTO_PAGO)'+
                    'VALUES(:BOMBA, :ID_TANQUE, :DATAHORA , :VALOR_PAGO, :QUANTIDADE, :IMPOSTO_PAGO)');

  QryAbastecimento.Params.ParamByName('BOMBA').AsString := bomba;
  QryAbastecimento.Params.ParamByName('ID_TANQUE').AsString := QryBombaID_TANQUE.AsString;
  QryAbastecimento.Params.ParamByName('DATAHORA').AsString := data;
  QryAbastecimento.Params.ParamByName('VALOR_PAGO').AsCurrency  := StrToCurr(copy(MaskB3.Text,4,4));
  QryAbastecimento.Params.ParamByName('QUANTIDADE').AsCurrency  :=  StrToCurr(EdtB3.Text);
  QryAbastecimento.Params.ParamByName('IMPOSTO_PAGO').AsCurrency  := imposto;
  QryAbastecimento.ExecSQL;
  MessageDlg('Abastecimento finalizado', mtInformation, [mbOK], 0);


  volumetanque := volumetanque -  StrToCurr(EdtB3.Text);

  QryVolumeTanque.SQL.Clear;
  QryVolumeTanque.SQL.Add('UPDATE  TBTANQUE SET LITROS =  '+ CurrToStr(volumetanque));
  QryVolumeTanque.SQL.Add('where ID_TANQUE = '''+QryBombaID_TANQUE.AsString+'''');
  QryVolumeTanque.ExecSQL;
end;

procedure TFrmBombas.BtnAbastecerB4Click(Sender: TObject);
begin
  bomba := 'BOMBA4';
  QryBomba.Close;
  QryBomba.Params.ParamByName('BOMBA').Value := bomba;
  QryBomba.open;

  QryTanque.SQL.Clear;
  QryTanque.SQL.Add('SELECT * FROM TBTANQUE WHERE ID_TANQUE =''' + QryBombaID_TANQUE.AsString+'''' );
  QryTanque.close;
  QryTanque.Open;


  volumetanque :=  QryTanqueLITROS.AsFloat;

  if volumetanque <= 0 then
    raise Exception.Create('Tanque de combustível vazio');


  if  QryBombaBOMBA.AsString = EmptyStr then
    raise Exception.Create('Bomba não cadastrada');


  abastecido := 0;

  mlgasolina := 0.100;

  imposto := StrToCurr(copy(MaskB4.Text,4,4));

  percentual := QryBombaIMPOSTO.AsCurrency;

  percentual := percentual/100;

  imposto := imposto * percentual;

  valorpago :=  StrToCurr(copy(MaskB4.Text,4,4));

  valorBomba := QryBombaVALOR_LITRO.AsCurrency/10;

  while  valorpago > valorBomba do
  begin
    mlgasolina := mlgasolina + 0.100;

    valorpago := valorpago - valorBomba;
  end;
  EdtB4.Text := CurrToStr(mlgasolina * 1000);

  MemoNotab4.Clear;

  data := ( FormatDateTime('dd.mm.yyyy hh:MM:ss', Now));

  MemoNotab4.Lines.Add('Valor Pago : ' + MaskB4.Text);
  MemoNotab4.Lines.Add('Imposto encima do valor pago: ' + CurrToStr(imposto));
  MemoNotab4.Lines.Add('Quantidade Abastecida: '+ EdtB4.Text +'Ml/Lt');
  MemoNotab4.Lines.Add('Data/Horário: ' + data);

  QryAbastecimento.SQL.Clear;
  QryAbastecimento.SQL.Add('INSERT INTO  TBABASTECIMENTO(BOMBA, ID_TANQUE, DATAHORA , VALOR_PAGO, QUANTIDADE, IMPOSTO_PAGO)'+
                    'VALUES(:BOMBA, :ID_TANQUE, :DATAHORA , :VALOR_PAGO, :QUANTIDADE, :IMPOSTO_PAGO)');

  QryAbastecimento.Params.ParamByName('BOMBA').AsString := bomba;
  QryAbastecimento.Params.ParamByName('ID_TANQUE').AsString := QryBombaID_TANQUE.AsString;
  QryAbastecimento.Params.ParamByName('DATAHORA').AsString := data;
  QryAbastecimento.Params.ParamByName('VALOR_PAGO').AsCurrency  := StrToCurr(copy(MaskB4.Text,4,4));
  QryAbastecimento.Params.ParamByName('QUANTIDADE').AsCurrency  :=  StrToCurr(EdtB4.Text);
  QryAbastecimento.Params.ParamByName('IMPOSTO_PAGO').AsCurrency  := imposto;
  QryAbastecimento.ExecSQL;
  MessageDlg('Abastecimento finalizado', mtInformation, [mbOK], 0);


  volumetanque := volumetanque -  StrToCurr(EdtB4.Text);

  QryVolumeTanque.SQL.Clear;
  QryVolumeTanque.SQL.Add('UPDATE  TBTANQUE SET LITROS =  '+ CurrToStr(volumetanque));
  QryVolumeTanque.SQL.Add('where ID_TANQUE = '''+QryBombaID_TANQUE.AsString+'''');
  QryVolumeTanque.ExecSQL;
end;

procedure TFrmBombas.BtnBomba1Click(Sender: TObject);
begin
  bomba := 'BOMBA1';
  QryBomba.Close;
  QryBomba.Params.ParamByName('BOMBA').Value := bomba;
  QryBomba.open;

  QryTanque.SQL.Clear;
  QryTanque.SQL.Add('SELECT * FROM TBTANQUE WHERE ID_TANQUE =''' + QryBombaID_TANQUE.AsString+'''' );
  QryTanque.close;
  QryTanque.Open;


  volumetanque :=  QryTanqueLITROS.AsFloat;

  if volumetanque <= 0 then
    raise Exception.Create('Tanque de combustível vazio');


  if  QryBombaBOMBA.AsString = EmptyStr then
    raise Exception.Create('Bomba não cadastrada');



  abastecido := 0;

  mlgasolina := 0.100;

  imposto := StrToCurr(copy(MaskB1.Text,4,4));

  percentual := QryBombaIMPOSTO.AsCurrency;

  percentual := percentual/100;

  imposto := imposto * percentual;

  valorpago :=  StrToCurr(copy(MaskB1.Text,4,4));

  valorBomba := QryBombaVALOR_LITRO.AsCurrency/10;

  while  valorpago > valorBomba do
  begin
    mlgasolina := mlgasolina + 0.100;

    valorpago := valorpago - valorBomba;
  end;
  EdtB1.Text := CurrToStr(mlgasolina * 1000);

  MemoNotab1.Clear;

   data := ( FormatDateTime('dd.mm.yyyy hh:MM:ss', Now));

  MemoNotab1.Lines.Add('Valor Pago : ' + MaskB1.Text);
  MemoNotab1.Lines.Add('Imposto encima do valor pago: ' + CurrToStr(imposto));
  MemoNotab1.Lines.Add('Quantidade Abastecida: '+ EdtB1.Text +'Ml/Lt');
  MemoNotab1.Lines.Add('Data/Horário: ' + data);

  QryAbastecimento.SQL.Clear;
  QryAbastecimento.SQL.Add('INSERT INTO  TBABASTECIMENTO(BOMBA, ID_TANQUE, DATAHORA , VALOR_PAGO, QUANTIDADE, IMPOSTO_PAGO)'+
                    'VALUES(:BOMBA, :ID_TANQUE, :DATAHORA , :VALOR_PAGO, :QUANTIDADE, :IMPOSTO_PAGO)');

  QryAbastecimento.Params.ParamByName('BOMBA').AsString := bomba;
  QryAbastecimento.Params.ParamByName('ID_TANQUE').AsString := QryBombaID_TANQUE.AsString;
  QryAbastecimento.Params.ParamByName('DATAHORA').AsString := data;
  QryAbastecimento.Params.ParamByName('VALOR_PAGO').AsCurrency  := StrToCurr(copy(MaskB1.Text,4,4));
  QryAbastecimento.Params.ParamByName('QUANTIDADE').AsCurrency  :=  StrToCurr(EdtB1.Text);
  QryAbastecimento.Params.ParamByName('IMPOSTO_PAGO').AsCurrency  := imposto;
  QryAbastecimento.ExecSQL;
  MessageDlg('Abastecimento finalizado', mtInformation, [mbOK], 0);


  volumetanque := volumetanque -  StrToCurr(EdtB1.Text);

  QryVolumeTanque.SQL.Clear;
  QryVolumeTanque.SQL.Add('UPDATE  TBTANQUE SET LITROS =  '+ CurrToStr(volumetanque));
  QryVolumeTanque.SQL.Add('where ID_TANQUE = '''+QryBombaID_TANQUE.AsString+'''');
  QryVolumeTanque.ExecSQL;
end;

end.
