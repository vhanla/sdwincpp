unit functions;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient,
  System.DateUtils, System.Math;

function GetSDReleases: TStringList;
function ISO8601ToDateTime(const ADate: string): TDateTime;
function AppPath: string;
function GetWidthRatio(Height: Integer; const AspectRatio: string): Integer;
function GetHeightRatio(Width: Integer; const AspectRatio: string): Integer;

implementation

function GetSDReleases: TStringList;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  JsonObj, AssetsObj: TJSONObject;
  JsonArray: TJSONArray;
  JsonValue: TJSONValue;
  I: Integer;
  Url, TagName, FileName: string;
  ResultList: TStringList;
begin
  ResultList := TStringList.Create;
  HttpClient := THTTPClient.Create;
  try
    Response := HttpClient.Get('https://api.github.com/repos/leejet/stable-diffusion.cpp/releases/latest');
    if Response.StatusCode = 200 then
    begin
      JsonObj := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONObject;
      try
        TagName := JsonObj.GetValue('tag_name').Value;
        JsonArray := JsonObj.GetValue('assets') as TJSONArray;
        for I := 0 to JsonArray.Count - 1 do
        begin
          AssetsObj := JsonArray.Items[I] as TJSONObject;
          FileName := AssetsObj.GetValue('name').Value;
          Url := AssetsObj.GetValue('browser_download_url').Value;

          // Filter conditions
          ResultList.AddPair(FileName, Url);
        end;
      finally
        JsonObj.Free;
      end;
    end;

    Result := ResultList;
  finally
    HttpClient.Free;
//    ResultList.Free;
  end;
end;

function ISO8601ToDateTime(const ADate: string): TDateTime;
var
  DateValue: string;
  TimeValue: string;
  Y, M, D, H, N, S: Word;
begin
  DateValue := Copy(ADate, 1, 10);
  TimeValue := Copy(ADate, 12, 8);
  Y := StrToInt(Copy(DateValue, 1, 4));
  M := StrToInt(Copy(DateValue, 6, 2));
  D := StrToInt(Copy(DateValue, 9, 2));
  H := StrToInt(Copy(TimeValue, 1, 2));
  N := StrToInt(Copy(TimeValue, 4, 2));
  S := StrToInt(Copy(TimeValue, 7, 2));
  Result := EncodeDateTime(Y, M, D, H, N, S, 0);
end;

function AppPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function ParseAspectRatio(const AspectRatio: string; out Width, Height: Integer): Boolean;
var
  Parts: TArray<string>;
begin
  Result := False;
  Parts := AspectRatio.Split([':']);
  if Length(Parts) = 2 then
  begin
    Result := TryStrToInt(Parts[0], Width) and TryStrToInt(Parts[1], Height);
  end;
end;

function RoundToNearestMultipleOf8(Value: Double): Integer;
begin
  Result := Round(Value/8) * 8;
end;

function GetWidthRatio(Height: Integer; const AspectRatio: string): Integer;
var
  RatioWidth, RatioHeight: Integer;
  CalculatedWidth: Double;
begin
  Result := 0;
  if ParseAspectRatio(AspectRatio, RatioWidth, RatioHeight) then
  begin
    CalculatedWidth := Height * (RatioWidth / RatioHeight);
    Result := RoundToNearestMultipleOf8(CalculatedWidth);
  end;

end;

function GetHeightRatio(Width: Integer; const AspectRatio: string): Integer;
var
  RatioWidth, RatioHeight: Integer;
  CalculatedHeight: Double;
begin
  Result := 0;
  if ParseAspectRatio(AspectRatio, RatioWidth, RatioHeight) then
  begin
    CalculatedHeight := Width * (RatioHeight / RatioWidth);
    Result := RoundToNearestMultipleOf8(CalculatedHeight);
  end;

end;

end.
