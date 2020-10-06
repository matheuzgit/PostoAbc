program SysCombo;

uses
  Vcl.Forms,
  ufrPrincipal in 'C:\Users\mathe\Documents\Embarcadero\Studio\Projects\ufrPrincipal.pas' {FrmPrincipal},
  ufrBombas in 'ufrBombas.pas' {FrmBombas},
  UDados in 'UDados.pas' {DataModule1: TDataModule},
  UfrMenu in 'UfrMenu.pas' {FrmMenu},
  UfrCadastroBombas in 'UfrCadastroBombas.pas' {FrmCadBombas},
  ufrCadastroTanque in 'ufrCadastroTanque.pas' {FrmCadastroTanque},
  UfrConsultaTanque in 'UfrConsultaTanque.pas' {FrmConsultatanque},
  ufrAbastercerTanque in 'ufrAbastercerTanque.pas' {FrmAbastercerTanque},
  UfrpRelatorioAbastecimento in 'UfrpRelatorioAbastecimento.pas' {FrpRelatorioAbastecimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrpRelatorioAbastecimento, FrpRelatorioAbastecimento);
  Application.Run;
end.
