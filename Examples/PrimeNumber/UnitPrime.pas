unit UnitPrime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TFormPrime = class(TForm)
    pgc1: TPageControl;
    tsGenPrime: TTabSheet;
    btnGen: TButton;
    edtMax: TEdit;
    mmoResult: TMemo;
    tsIsPrime: TTabSheet;
    lblCheck: TLabel;
    edtToPrime: TEdit;
    btnIsPrime: TButton;
    chkQuickGen: TCheckBox;
    procedure btnGenClick(Sender: TObject);
    procedure btnIsPrimeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrime: TFormPrime;

implementation

uses
  CnPrimeNumber;

{$R *.DFM}

function IsPrime(N: Cardinal): Boolean;
var
  I: Cardinal;
  Sq: Cardinal;
begin
  Result := False;
  if N < 2 then
    Exit;
  if N = 2 then
  begin
    Result := True;
    Exit;
  end;

  if N mod 2 = 0 then
    Exit;

  Sq := Trunc(Sqrt(N));
  I := 3;
  while I <= Sq do
  begin
    if N mod I = 0 then
      Exit;
    Inc(I, 2);
  end;
  Result := True;
end;

procedure TFormPrime.btnGenClick(Sender: TObject);
var
  M, I: Cardinal;
  List: TStrings;
  T: DWORD;
begin
  M := StrToInt64(edtMax.Text);
  mmoResult.Clear;
  if chkQuickGen.Checked then
  begin
    List := TStringList.Create;
    T := GetTickCount;
    for I := 2 to M do
    begin
      if CnUInt32IsPrime(I) then
        List.Add(IntToStr(I) + ',');
      if I mod 1000000 = 0 then
        mmoResult.Lines[0] := FloatToStr(I / M) + ' - ' + IntToStr(GetTickCount - T);
    end;
    mmoResult.Lines.Assign(List);
    mmoResult.Lines.SaveToFile('C:\prime.txt');
    List.Free;
  end
  else
    for I := 2 to M do
      if IsPrime(I) then
        mmoResult.Lines.Add(IntToStr(I) + ',');
end;

procedure TFormPrime.btnIsPrimeClick(Sender: TObject);
var
  N: Cardinal;
begin
  N := Cardinal(StrToInt64(edtToPrime.Text));
  if CnUInt32IsPrime(N) then
    ShowMessage('Is Prime Number.')
  else
    ShowMessage('Not Prime Number.');
end;

end.
