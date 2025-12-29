unit fGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Data.DB, DBAccess, Uni, MemDS, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, UniProvider, SQLiteUniProvider;

type
  TDBGrid = class(TForm)
    DBGridEh1: TDBGridEh;
    UniConnection1: TUniConnection;
    UniQuery1: TUniQuery;
    UniDataSource1: TUniDataSource;
    SQLiteUniProvider1: TSQLiteUniProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBGrid: TDBGrid;

implementation

{$R *.dfm}

end.
