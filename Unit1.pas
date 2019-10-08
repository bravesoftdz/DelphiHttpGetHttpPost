unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnHttpGet: TButton;
    IdHTTP: TIdHTTP;
    btnHttpPost: TButton;

    procedure btnHttpGetClick(Sender: TObject);
    procedure btnHttpPostClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{
  HttpGet
  ���Get��Ҫ��������������ֱ���ڵ�ַ����ӣ�����������&����
  �磺http://dict.youdao.com��param1=1&param2=2
}
procedure TForm1.btnHttpGetClick(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  Url: string; // �����ַ
  ResponseStream: TStringStream; // ������Ϣ
  ResponseStr: string;
begin
  // ����IDHTTP�ؼ�
  IdHTTP := TIdHTTP.Create(nil);
  // TStringStream�������ڱ�����Ӧ��Ϣ
  ResponseStream := TStringStream.Create('');
  try
    // �����ַ
    Url := 'http://dict.youdao.com/';
    try
      IdHTTP.Get(Url, ResponseStream);
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    // ��ȡ��ҳ���ص���Ϣ
    ResponseStr := ResponseStream.DataString;
    // ��ҳ�еĴ�������ʱ����Ҫ����UTF8����
    ResponseStr := UTF8Decode(ResponseStr);
    ShowMessage(ResponseStr);
  finally
    IdHTTP.Free;
    ResponseStream.Free;
  end;
end;
{
   HttpPost
}
procedure TForm1.btnHttpPostClick(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  Url: string; // �����ַ
  ResponseStream: TStringStream; // ������Ϣ
  ResponseStr: string;

  RequestList: TStringList; // ������Ϣ
  RequestStream: TStringStream;
begin
  // ����IDHTTP�ؼ�
  IdHTTP := TIdHTTP.Create(nil);
  // TStringStream�������ڱ�����Ӧ��Ϣ
  ResponseStream := TStringStream.Create('');

  RequestStream := TStringStream.Create('');
  RequestList := TStringList.Create;
  try
    Url := 'http://f.youdao.com/?path=fanyi&vendor=fanyiinput';
    try
      // ���б�ķ�ʽ�ύ����
      RequestList.Add('text=love');
      IdHTTP.Post(Url, RequestList, ResponseStream);

      // �����ķ�ʽ�ύ����
      RequestStream.WriteString('text=love');
      IdHTTP.Post(Url, RequestStream, ResponseStream);
    except
      on e: Exception do
      begin
        Application.MessageBox(PWideChar(e.Message), PWideChar('Error'));
      end;
    end;
    // ��ȡ��ҳ���ص���Ϣ
    ResponseStr := ResponseStream.DataString;
    // ��ҳ�еĴ�������ʱ����Ҫ����UTF8����
    ResponseStr := UTF8Decode(ResponseStr);
    showMessage(responsestr);
  finally
    IdHTTP.Free;
    RequestList.Free;
    RequestStream.Free;
    ResponseStream.Free;
  end;
end;


end.
