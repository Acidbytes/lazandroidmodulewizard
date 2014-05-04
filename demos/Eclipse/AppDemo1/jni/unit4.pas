{Hint: save all files to location: \jni }
unit unit4;
  
{$mode delphi}
  
interface
  
uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls;
  
type

  { TAndroidModule4 }

  TAndroidModule4 = class(jForm)
      jButton1: jButton;
      jEditText1: jEditText;
      jEditText2: jEditText;
      jScrollView1: jScrollView;
      jTextView1: jTextView;
      procedure DataModuleActive(Sender: TObject);
      procedure DataModuleCloseQuery(Sender: TObject; var CanClose: boolean);
      procedure DataModuleCreate(Sender: TObject);
      procedure DataModuleJNIPrompt(Sender: TObject);
      procedure DataModuleRotate(Sender: TObject; rotate: integer;
        var rstRotate: integer);
      procedure jButton1Click(Sender: TObject);
    private
      {private declarations}
    public
      {public declarations}
  end;
  
var
  AndroidModule4: TAndroidModule4;

implementation
  
{$R *.lfm}
  

{ TAndroidModule4 }

procedure TAndroidModule4.jButton1Click(Sender: TObject);
var
  str: TStringList;

begin
   str:= TStringList.Create;

   str.Add('Screen: '+ IntToStr(Self.App.Screen.WH.Width) + 'x' + IntToStr(Self.App.Screen.WH.Height));
   str.Add('App Path: '+Self.App.Path.App);
   str.Add('App Path Dat: '+Self.App.Path.Dat);
   str.Add('App Path DataBase: '+Self.App.Path.DataBase);
   str.Add('Phone Number: '+Self.App.Device.PhoneNumber);
   str.Add('Device ID: '+Self.App.Device.ID);
   str.Add('Date Time: '+Self.GetDateTime);

   jEditText1.Text:= str.Text;
   jEditText2.Text:= str.Text;

   str.Free
end;

procedure TAndroidModule4.DataModuleCreate(Sender: TObject);
begin  //this initialization code is need here to fix Laz4Andoid  *.lfm parse.... why parse fails?
  Self.ActivityMode:= actRecyclable;
  //Self.BackgroundColor:= colbrBlack;
  //mode delphi
  Self.OnJNIPrompt:= DataModuleJNIPrompt;
  Self.OnRotate:= DataModuleRotate;
  Self.OnCloseQuery:= DataModuleCloseQuery;
  Self.OnActive:= DataModuleActive;
end;

procedure TAndroidModule4.DataModuleCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:= True;
end;

procedure TAndroidModule4.DataModuleActive(Sender: TObject);
begin
  //
end;

procedure TAndroidModule4.DataModuleJNIPrompt(Sender: TObject);
begin
  jEditText2.Parent:= jScrollView1.View;  //change the parent here!
  Self.Show;
end;

procedure TAndroidModule4.DataModuleRotate(Sender: TObject; rotate: integer;
  var rstRotate: integer);
begin
  Self.UpdateLayout;
end;

end.