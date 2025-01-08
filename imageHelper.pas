unit imageHelper;

interface

uses
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, StableDiffusion, System.SysUtils,
  System.Classes, Winapi.Windows, Vcl.Imaging.GIFImg, Vcl.Graphics;

function SdImageToBitmap(const SDImage: TSDImage): TBitmap;
function BitmapToSdImage(const Bitmap: TBitmap): TSDImage;
procedure FreeSDImage(var SDImage: TSDImage);
function SDLoadFromFile(const Filename: string): TSDImage;
function SDLoadFromStream(Stream: TStream): TSDImage;

implementation

function SdImageToBitmap(const SDImage: TSDImage): TBitmap;
var
  Bitmap: TBitmap;
  Row, Col: Integer;
  SrcPtr, DestPtr: PByte;
  PixelFormat: TPixelFormat;
begin
  Bitmap := Vcl.Graphics.TBitmap.Create;
  try
    case SDImage.Channel of
      1: PixelFormat := pf8bit;
      3: PixelFormat := pf24bit;
      4: PixelFormat := pf32bit;
    else
      raise Exception.Create('Unsupported channel count');
    end;

    Bitmap.Width := SDImage.Width;
    Bitmap.Height := SDImage.Height;
    Bitmap.PixelFormat := PixelFormat;

    case SDImage.Channel of
      1: // Grayscale
        begin
          for Row := 0 to SDImage.Height - 1 do
          begin
            SrcPtr := SDImage.Data + Row * SDImage.Width;
            DestPtr := Bitmap.ScanLine[Row];
            Move(SrcPtr^, DestPtr^, SDImage.Width);
          end;
        end;
      3: // RGB
        begin
          for Row := 0 to SDImage.Height - 1 do
          begin
            SrcPtr := SDImage.Data + Row * SDImage.Width * 3;
            DestPtr := Bitmap.ScanLine[Row];
            for Col := 0 to SDImage.Width - 1 do
            begin
              DestPtr^ := SrcPtr[2]; Inc(DestPtr);
              DestPtr^ := SrcPtr[1]; Inc(DestPtr);
              DestPtr^ := SrcPtr[0]; Inc(DestPtr);
              Inc(SrcPtr, 3);
            end;
          end;
        end;
      4: // RGBA
        begin
          for Row := 0 to SDImage.Height - 1 do
          begin
            SrcPtr := SDImage.Data + Row * SDImage.Width * 4;
            DestPtr := Bitmap.ScanLine[Row];
            Move(SrcPtr^, DestPtr^, SDImage.Width * 4);
          end;
        end;
    end;
  except
    Bitmap.Free;
    raise;
  end;
  Result := Bitmap;
end;

function BitmapToSdImage(const Bitmap: TBitmap): TSDImage;
var
  Row, Col: Integer;
  SrcPtr, DestPtr: PByte;
begin
  Result.Width := Bitmap.Width;
  Result.Height := Bitmap.Height;

  case Bitmap.PixelFormat of
    pf8bit: Result.Channel := 1;
    pf24bit: Result.Channel := 3;
    pf32bit: Result.Channel := 4;
  else
    raise Exception.Create('Unsupported pixel format');
  end;

  GetMem(Result.Data, Result.Width * Result.Height * Result.Channel);

  case Result.Channel of
    1: // Grayscale
      begin
        for Row := 0 to Result.Height - 1 do
        begin
          SrcPtr := Bitmap.ScanLine[Row];
          DestPtr := Result.Data + Row * Result.Width;
          Move(SrcPtr^, DestPtr^, Result.Width);
        end;
      end;
    3: // RGB
      begin
        for Row := 0 to Result.Height - 1 do
        begin
          SrcPtr := Bitmap.ScanLine[Row];
          DestPtr := Result.Data + Row * Result.Width * 3;
          for Col := 0 to Result.Width - 1 do
          begin
            DestPtr[2] := SrcPtr^; Inc(SrcPtr);
            DestPtr[1] := SrcPtr^; Inc(SrcPtr);
            DestPtr[0] := SrcPtr^; Inc(SrcPtr);
            Inc(DestPtr, 3);
          end;
        end;
      end;
    4: // RGBA
      begin
        for Row := 0 to Result.Height - 1 do
        begin
          SrcPtr := Bitmap.ScanLine[Row];
          DestPtr := Result.Data + Row * Result.Width * 4;
          Move(SrcPtr^, DestPtr^, Result.Width * 4);
        end;
      end;
  end;
end;

procedure FreeSDImage(var SDImage: TSDImage);
begin
  if Assigned(SDImage.Data) then
  begin
    FreeMem(SDImage.Data);
    SDImage.Data := nil;
  end;
  SDImage.Width := 0;
  SDImage.Height := 0;
  SDImage.Channel := 0;
end;

function SDLoadFromFile(const Filename: string): TSDImage;
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try
    Result := SDLoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function SDLoadFromStream(Stream: TStream): TSDImage;
var
  Bitmap: TBitmap;
  PNG: TPngImage;
  JPEG: TJPEGImage;
  GIF: TGIFImage;
  FileExt: string;
begin
  FileExt := LowerCase(ExtractFileExt(Stream.ClassName));

  if FileExt = '.png' then
  begin
    PNG := TPngImage.Create;
    try
      PNG.LoadFromStream(Stream);
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(PNG);
        Result := BitmapToSdImage(Bitmap);
      finally
        Bitmap.Free;
      end;
    finally
      PNG.Free;
    end;
  end
  else if (FileExt = '.jpg') or (FileExt = '.jpeg') then
  begin
    JPEG := TJPEGImage.Create;
    try
      JPEG.LoadFromStream(Stream);
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(JPEG);
        Result := BitmapToSdImage(Bitmap);
      finally
        Bitmap.Free;
      end;
    finally
      JPEG.Free;
    end;
  end
  else if FileExt = '.gif' then
  begin
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromStream(Stream);
      Bitmap := TBitmap.Create;
      try
        Bitmap.Assign(GIF);
        Result := BitmapToSdImage(Bitmap);
      finally
        Bitmap.Free;
      end;
    finally
      GIF.Free;
    end;
  end
  else if FileExt = '.bmp' then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.LoadFromStream(Stream);
      Result := BitmapToSdImage(Bitmap);
    finally
      Bitmap.Free;
    end;
  end
  else
    Raise Exception.Create('Unsupported file format');
end;

end.
