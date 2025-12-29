program SQLCodeGenerator;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  fGrid in 'fGrid.pas' {DBGrid},
  fConnect in 'fConnect.pas' {Connection};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDBGrid, DBGrid);
  Application.CreateForm(TConnection, Connection);
  Application.Run;
end.
