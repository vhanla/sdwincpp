unit Config.Base;

interface

uses
  System.Classes,
  system.SysUtils,
  System.JSON,
  Rest.Json,
  System.Generics.Collections;

type
  // Generic base class for configuration items
  TConfigItem<T> = class
  private
    FName: string;
    FValue: T;
    FEnabled: Boolean;
  public
    constructor Create(const AName: string; const AValue: T; AEnabled: Boolean = True);
    property Name: string read FName write FName;
    property Value: T read FValue write FValue;
    property Enabled: Boolean read FEnabled write FEnabled;
  end;

  // Generic configuration collection with extended functionality
  TConfigCollection<T: class> = class(TObjectList<T>)
  private
    FDefaultIndex: Integer;
  public
    constructor Create(AOwnsObjects: Boolean = True);
    function FindByName(const AName: string): T;
    property DefaultIndex: Integer read FDefaultIndex write FDefaultIndex;
  end;

  // Generic Settings Manager
  TSettingsManager<T: class, constructor> = class
  private
    class var FDefaultSettingsPath: string;
    class function GetDefaultSettingsPath(const AFileName: string = ''): string;
  public
    // Load settings with comprehensive error handling
    class function LoadSettings(const APath: string = ''): T;

    // Save settings with exception management
    class procedure SaveSettings(const ASettings: T; const APath: string = '');

    // Ensure settings exist, creating defaults if necessary
    class function EnsureSettings(const APath: string = ''): T;

    // Optional: Create default settings
    class function CreateDefaultSettings: T; virtual;
  end;

implementation

{ TConfigItem<T> }

constructor TConfigItem<T>.Create(const AName: string; const AValue: T;
  AEnabled: Boolean);
begin
  inherited Create;
  FName := AName;
  FValue := AValue;
  FEnabled := AEnabled;
end;

{ TConfigCollection<T> }

constructor TConfigCollection<T>.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FDefaultIndex := -1;
end;

function TConfigCollection<T>.FindByName(const AName: string): T;
var
  Item: T;
begin
  Result := nil;
  for Item in Self do
    if (Item as TConfigItem<string>).Name = AName then
      Exit(Item);
end;

{ TSettingsManager<T> }

class function TSettingsManager<T>.CreateDefaultSettings: T;
begin
  Result := T.Create;
end;

class function TSettingsManager<T>.EnsureSettings(const APath: string): T;
begin
  Result := LoadSettings(APath);
end;

class function TSettingsManager<T>.GetDefaultSettingsPath(
  const AFileName: string): string;
var
  FileName: string;
begin
  // Use provided filename or generate from type name
  FileName := AFileName;
  if FileName = '' then
    FileName := LowerCase(Copy(T.ClassName, 2)) + '.json';

  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + FileName;
  { TODO : Support userprofile app path instead of executable's path as default }
end;

class function TSettingsManager<T>.LoadSettings(const APath: string): T;
var
  SettingsFile: TStringList;
  JSONValue: TJSONValue;
begin
  Result := nil;
  SettingsFile := TStringList.Create;
  try
    try
      // Use provided path or default path
      var TargetPath := APath;
      if TargetPath = '' then
        TargetPath := GetDefaultSettingsPath;

      // Load file only if it exists
      if FileExists(TargetPath) then
      begin
        SettingsFile.LoadFromFile(TargetPath);
        JSONValue := TJSONObject.ParseJSONValue(SettingsFile.Text);
        try
          if Assigned(JSONValue) then
            Result := TJson.JsonToObject<T>(JSONValue as TJSONObject)
          else
            Result := CreateDefaultSettings;
        finally
          JSONValue.Free;
        end;
      end
      else
        Result := CreateDefaultSettings;

    except
      on E: Exception do
      begin
        // Fallback to default settings
        Result := CreateDefaultSettings;
      end;
    end;
  finally
    SettingsFile.Free;
  end;
end;

class procedure TSettingsManager<T>.SaveSettings(const ASettings: T;
  const APath: string);
var
  SettingsFile: TStringList;
  JSONStr: string;
begin
  SettingsFile := TStringList.Create;
  try
    try
      var TargetPath := APath;
      if TargetPath = '' then
        TargetPath := GetDefaultSettingsPath;

      // Serialize settings to JSON
      JSONStr := TJson.ObjectToJsonString(ASettings);
      SettingsFile.Text := JSONStr;

      // Ensure directory exists
      ForceDirectories(ExtractFilePath(TargetPath));
      SettingsFile.SaveToFile(TargetPath);

    except
      on E: Exception do
      begin
        raise Exception.Create('Failed to save settings: ' + E.Message);
      end;
    end;
  finally
    SettingsFile.Free;
  end;
end;

end.
