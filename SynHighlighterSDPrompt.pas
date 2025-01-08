{
TODO: sentence fix to highlight the background of the sentence, i.e. comma separated sentences, period and new lines
}
unit SynHighlighterSDPrompt;

interface

uses
  Windows,
  Classes,
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynUnicode,
  SysUtils;

type
  TtkTokenKind = (tkText, tkEmphasis, tkLora, tkLevel, tkSpace,
                  tkComment, tkSymbol, tkUnknown, tkComma, tkSentence, tkUnderEmphasis);
  TRangeState = (rsUnknown, rsComment, rsEmphasis, rsUnderEmphasis, rsLevel, rsLora);

  TSynSDPromptSyn = class(TSynCustomHighlighter)
  private
    FTokenID: TtkTokenKind;
    fRange: TRangeState;
    fEmphasisLevel: Integer;
    fTextAttri: TSynHighlighterAttributes;
    fEmphasisAttri: TSynHighlighterAttributes;
    fUnderEmphasisAttri: TSynHighlighterAttributes;
    fLoraAttri: TSynHighlighterAttributes;
    fLevelAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fCommentAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fUnknownAttri: TSynHighlighterAttributes;
    fCommaAttri: TSynHighlighterAttributes;
    fSentenceAttri: TSynHighlighterAttributes;
    procedure CRProc;
    procedure TextProc;
    procedure LFProc;
    procedure NullProc;
    procedure CommentProc;
    procedure SpaceProc;
    procedure EmphasisProc;
    procedure UnderEmphasisProc;
    procedure LevelProc;
    procedure LoraProc;
    procedure SymbolProc;
    procedure UnknownProc;
    procedure CommaProc;
  protected
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
  public
    class function GetLanguageName: string; override;
    class function GetFriendlyLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetTokenID: TtkTokenKind;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    procedure Next; override;
  published
    property TextAttri: TSynHighlighterAttributes read fTextAttri
      write fTextAttri;
    property EmphasisAttri: TSynHighlighterAttributes read fEmphasisAttri
      write fEmphasisAttri;
    property UnderEmphasisAttri: TSynHighlighterAttributes read fUnderEmphasisAttri
      write fUnderEmphasisAttri;
    property LoraAttri: TSynHighlighterAttributes read fLoraAttri
      write fLoraAttri;
    property LevelAttri: TSynHighlighterAttributes read fLevelAttri
      write fLevelAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri
      write fSpaceAttri;
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri
      write fCommentAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri
      write fSymbolAttri;
    property CommaAttri: TSynHighlighterAttributes read fCommaAttri
      write fCommaAttri;
    property SentenceAttri: TSynHighlighterAttributes read fSentenceAttri
      write fSentenceAttri;
  end;

implementation

uses
  SynEditStrConst;

resourcestring
  SYNS_LangSDPrompt = 'SDPrompt';
  SYNS_FriendlyLangSDPrompt = 'Stable Diffusion Prompt';
  SYNS_AttrEmphasis = 'Emphasis';
  SYNS_FriendlyAttrEmphasis = 'Emphasis';
  SYNS_AttrUnderEmphasis = 'UnderEmphasis';
  SYNS_FriendlyAttrUnderEmphasis = 'UnderEmphasis';
  SYNS_AttrLora = 'Lora';
  SYNS_FriendlyAttrLora = 'Lora';
  SYNS_AttrLevel = 'Level';
  SYNS_FriendlyAttrLevel = 'Level';
  SYNS_AttrUnknown = 'Unknown';
  SYNS_FriendlyAttrUnknown = 'Unknown';
  SYNS_FilterSDPrompt = 'Stable Diffusion Prompt';
  SYNS_AttrComma = 'Comma';
  SYNS_FriendlyAttrComma = 'Comma';
  SYNS_AttrSentence = 'Sentence';
  SYNS_FriendlyAttrSentence = 'Sentence';

constructor TSynSDPromptSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fTextAttri := TSynHighlighterAttributes.Create(SYNS_AttrText, SYNS_FriendlyAttrText);
  AddAttribute(fTextAttri);

  fEmphasisAttri := TSynHighlighterAttributes.Create(SYNS_AttrEmphasis, SYNS_FriendlyAttrEmphasis);
  fEmphasisAttri.Style := [fsBold];
  AddAttribute(fEmphasisAttri);

  fUnderEmphasisAttri := TSynHighlighterAttributes.Create(SYNS_AttrUnderEmphasis, SYNS_FriendlyAttrUnderEmphasis);
  fUnderEmphasisAttri.Style := [fsItalic];
  AddAttribute(fUnderEmphasisAttri);

  fLoraAttri := TSynHighlighterAttributes.Create(SYNS_AttrLora, SYNS_FriendlyAttrLora);
  fLoraAttri.Foreground := clBlue;
  AddAttribute(fLoraAttri);

  fLevelAttri := TSynHighlighterAttributes.Create(SYNS_AttrLevel, SYNS_FriendlyAttrLevel);
  fLevelAttri.Foreground := clGreen;
  AddAttribute(fLevelAttri);

  fSpaceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSpace, SYNS_FriendlyAttrSpace);
  AddAttribute(fSpaceAttri);

  fCommentAttri := TSynHighlighterAttributes.Create(SYNS_AttrComment, SYNS_FriendlyAttrComment);
  AddAttribute(fCommentAttri);

  fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol, SYNS_FriendlyAttrSymbol);
  AddAttribute(fSymbolAttri);

  fUnknownAttri := TSynHighlighterAttributes.Create(SYNS_AttrUnknown, SYNS_FriendlyAttrUnknown);
  AddAttribute(fUnknownAttri);

  fCommaAttri := TSynHighlighterAttributes.Create(SYNS_AttrComma, SYNS_FriendlyAttrComma);
  AddAttribute(fCommaAttri);

  fSentenceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSentence, SYNS_FriendlyAttrSentence);
  AddAttribute(fSentenceAttri);

  SetAttributesOnChange(DefHighlightChange);
  fDefaultFilter := SYNS_FilterSDPrompt;
  fRange := rsUnknown;
  fEmphasisLevel := 0;
end;

procedure TSynSDPromptSyn.CRProc;
begin
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TSynSDPromptSyn.TextProc;
begin
  fTokenID := tkText;
  inc(Run);
end;

procedure TSynSDPromptSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynSDPromptSyn.NullProc;
begin
  fTokenID := tkUnknown;
  inc(Run);
end;

procedure TSynSDPromptSyn.CommaProc;
begin
  FTokenID := tkComma;
  inc(Run);
end;

procedure TSynSDPromptSyn.CommentProc;
begin
 fTokenID := tkComment;
 repeat
    case fLine[Run] of
      #0, #10: Break;
    end;
    inc(Run);
  until fLine[Run] = #13;
  Exit;
end;

procedure TSynSDPromptSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  while (FLine[Run] <= #32) and not IsLineEnd(Run) do inc(Run);
end;

procedure TSynSDPromptSyn.EmphasisProc;
begin
  Inc(Run);
  fTokenID := tkEmphasis;
  fEmphasisLevel := 1;
  while not IsLineEnd(Run) do
  begin
    case fLine[Run] of
      '(':
        begin
          Inc(Run);
          Inc(fEmphasisLevel);
        end;
      ')':
        begin
          Inc(Run);
          Dec(fEmphasisLevel);
          if fEmphasisLevel = 0 then
          begin
            fRange := rsUnknown;
            Exit;
          end;
        end;
      // '[' and ']' are now handled in UnderEmphasisProc
    end;
    Inc(Run);
  end;
end;

procedure TSynSDPromptSyn.LevelProc;
begin
  Inc(Run);
  fTokenID := tkLevel;
  fEmphasisLevel := 1;
  while not IsLineEnd(Run) do
  begin
    case fLine[Run] of
      '(':
        begin
          Inc(Run);
          Inc(fEmphasisLevel);
        end;
      ')':
        begin
          Inc(Run);
          Dec(fEmphasisLevel);
          if fEmphasisLevel = 0 then
          begin
            fRange := rsUnknown;
            Exit;
          end;
        end;
    end;
    Inc(Run);
  end;
end;

procedure TSynSDPromptSyn.LoraProc;
begin
  Inc(Run);
  fTokenID := tkLora;
  fEmphasisLevel := 1;
  while not IsLineEnd(Run) do
  begin
    case fLine[Run] of
      '<':
        begin
          Inc(Run);
          Inc(fEmphasisLevel);
        end;
      '>':
        begin
          Inc(Run);
          Dec(fEmphasisLevel);
          if fEmphasisLevel = 0 then
          begin
            fRange := rsUnknown;
            Exit;
          end;
        end;
    end;
    Inc(Run);
  end;
end;

procedure TSynSDPromptSyn.SymbolProc;
begin
  Inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynSDPromptSyn.UnderEmphasisProc;
begin
  Inc(Run);
  fTokenID := tkUnderEmphasis;
  fEmphasisLevel := 1;
  while not IsLineEnd(Run) do
  begin
    case fLine[Run] of
      '[':
        begin
          Inc(Run);
          Inc(fEmphasisLevel);
        end;
      ']':
        begin
          Inc(Run);
          Dec(fEmphasisLevel);
          if fEmphasisLevel = 0 then
          begin
            fRange := rsUnknown;
            Exit;
          end;
        end;
      // '(' and ')' are now handled in EmphasisProc
    end;
    Inc(Run);
  end;
end;

procedure TSynSDPromptSyn.UnknownProc;
begin
  Inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynSDPromptSyn.Next;
//var
//  IsSentence: Boolean;
begin
  fTokenPos := Run;
//  IsSentence := True;

  case fRange of
    rsComment: CommentProc;
  else
    fRange := rsUnknown;
    case fLine[Run] of
      #0: NullProc;
      #10:
        begin
          LFProc;
//          IsSentence := False; // Newline starts a new sentence
        end;
      #13:
        begin
          CRProc;
//          if FLine[Run] = #10 then
//            IsSentence := False; // CRLF starts a new sentence
        end;
      #1..#9, #11, #12, #14..#32:
        begin
          // Handle spaces within and outside of sentences
//          if IsSentence then
//          begin
//            fTokenID := tkSentence; // Include spaces within a sentence
//            Inc(Run);
//          end
//          else
            SpaceProc; // Ignore spaces outside a sentence
        end;
      '(':
        begin
          if fRange = rsUnknown then
          begin
            fRange := rsEmphasis;
            EmphasisProc;
          end
          else
            UnknownProc;
        end;
      '[':
        begin
          if fRange = rsUnknown then
          begin
            fRange := rsUnderEmphasis;
            UnderEmphasisProc;
          end
          else
            UnknownProc;
        end;
      '<':
        begin
          if fRange = rsUnknown then
          begin
            fRange := rsLora;
            LoraProc;
          end
          else
            UnknownProc;
        end;
      ':':
        begin
          if fRange = rsUnknown then
          begin
            fRange := rsLevel;
            LevelProc;
          end
          else
            UnknownProc;
        end;
      ',':
        begin
          CommaProc;
//          IsSentence := False; // Comma ends a sentence
        end;
      '.':
        begin
          SymbolProc;
//          IsSentence := False; // Period ends a sentence
        end
      else
        begin
          TextProc;
//          IsSentence := True; // Any other character starts a new sentence
        end;
    end;
  end;

//  if IsSentence then // If we are inside a sentence, use the sentence attribute
//    FTokenID := tkSentence
  // No need for this anymore: else if fTokenID...
//  else if FTokenID = tkText then
//    FTokenID := tkSentence;  // Treat consecutive text as part of the sentence

  inherited; // Let's SynEdit do its thing
end;

function TSynSDPromptSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynSDPromptSyn.GetEol: Boolean;
begin
  Result := Run = fLineLen + 1;
end;

function TSynSDPromptSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynSDPromptSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkEmphasis: Result := fEmphasisAttri;
    tkUnderEmphasis: Result := fUnderEmphasisAttri;
    tkLora: Result := fLoraAttri;
    tkLevel: Result := fLevelAttri;
    tkSpace: Result := fSpaceAttri;
    tkSymbol: Result := fSymbolAttri;
    tkText: Result := fTextAttri;
    tkUnknown: Result := fUnknownAttri;
    tkComma: Result := fCommaAttri;
    tkSentence: Result := fSentenceAttri;
    else
      Result := nil;
  end;
end;

function TSynSDPromptSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynSDPromptSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterSDPrompt;
end;

class function TSynSDPromptSyn.GetLanguageName: string;
begin
  Result := SYNS_LangSDPrompt;
end;

function TSynSDPromptSyn.GetSampleSource: string;
begin
  Result :=
    'Sample Stable Diffusion Prompt'#13#10 +
    'a majestic dragon (detailed scales:1.5), flying over a forest, ' +
    '(cinematic lighting:1.2), (foggy atmosphere:0.8), [cartoonish style]'#13#10 +
    'Negative prompt: low detail, blurry, pixelated, <lora:realistic:0.8>';
end;

class function TSynSDPromptSyn.GetFriendlyLanguageName: string;
begin
  Result := SYNS_FriendlyLangSDPrompt;
end;

initialization
  RegisterPlaceableHighlighter(TSynSDPromptSyn);
end.

(*unit SynHighlighterSDPrompt;

interface

uses
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynUnicode,
  SysUtils,
  Classes;

type
  TtkTokenKind = (
    tkAngleBrackets,
    tkDoubleParens,
    tkIdentifier,
    tkKey,
    tkLora,
    tkNull,
    tkNumber,
    tkPeriod,
    tkSeparator,
    tkSingleParens,
    tkSpace,
    tkSquareBrackets,
    tkUnknown,
    tkWeight);

  TRangeState = (rsUnKnown, rsLoraTag);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function (Index: Integer): TtkTokenKind of object;

type
  TSynSDPromptSyn = class(TSynCustomHighlighter)
  private
    fRange: TRangeState;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0..1] of TIdentFuncTableFunc;
    fAngleBracketsAttri: TSynHighlighterAttributes;
    fDoubleParensAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fLoraAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fPeriodAttri: TSynHighlighterAttributes;
    fSeparatorAttri: TSynHighlighterAttributes;
    fSingleParensAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fSquareBracketsAttri: TSynHighlighterAttributes;
    fWeightAttri: TSynHighlighterAttributes;
    function HashKey(Str: PWideChar): Cardinal;
    function FuncLora(Index: Integer): TtkTokenKind;
    procedure AngleBracketsProc;
    procedure IdentProc;
    procedure PeriodProc;
    procedure SeparatorProc;
    procedure SingleParensProc;
    procedure DoubleParensProc;
    procedure SquareBracketsProc;
    procedure WeightProc;
    procedure UnknownProc;
    function AltFunc(Index: Integer): TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PWideChar): TtkTokenKind;
    procedure NullProc;
    procedure NumberProc;
    procedure SpaceProc;
    procedure CRProc;
    procedure LFProc;
    procedure LoraTagOpenProc;
    procedure LoraTagProc;
  protected
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetFriendlyLanguageName: string; override;
    class function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: Integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetKeyWords(TokenKind: Integer): string; override;
    function GetTokenID: TtkTokenKind;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: Integer; override;
    function IsIdentChar(AChar: WideChar): Boolean; override;
    procedure Next; override;
  published
    property AngleBracketsAttri: TSynHighlighterAttributes read fAngleBracketsAttri write fAngleBracketsAttri;
    property DoubleParensAttri: TSynHighlighterAttributes read fDoubleParensAttri write fDoubleParensAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property LoraAttri: TSynHighlighterAttributes read fLoraAttri write fLoraAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property PeriodAttri: TSynHighlighterAttributes read fPeriodAttri write fPeriodAttri;
    property SeparatorAttri: TSynHighlighterAttributes read fSeparatorAttri write fSeparatorAttri;
    property SingleParensAttri: TSynHighlighterAttributes read fSingleParensAttri write fSingleParensAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property SquareBracketsAttri: TSynHighlighterAttributes read fSquareBracketsAttri write fSquareBracketsAttri;
    property WeightAttri: TSynHighlighterAttributes read fWeightAttri write fWeightAttri;
  end;

implementation

uses
  SynEditStrConst;

resourcestring
  SYNS_FilterSDPrompt = 'All files (*.* )|*.*';
  SYNS_LangSDPrompt = 'SDPrompt';
  SYNS_FriendlyLangSDPrompt = 'SDPrompt';
  SYNS_AttrAngleBrackets = 'AngleBrackets';
  SYNS_FriendlyAttrAngleBrackets = 'AngleBrackets';
  SYNS_AttrDoubleParens = 'DoubleParens';
  SYNS_FriendlyAttrDoubleParens = 'DoubleParens';
  SYNS_AttrLora = 'Lora';
  SYNS_FriendlyAttrLora = 'Lora';
  SYNS_AttrPeriod = 'Period';
  SYNS_FriendlyAttrPeriod = 'Period';
  SYNS_AttrSeparator = 'Separator';
  SYNS_FriendlyAttrSeparator = 'Separator';
  SYNS_AttrSingleParens = 'SingleParens';
  SYNS_FriendlyAttrSingleParens = 'SingleParens';
  SYNS_AttrSquareBrackets = 'SquareBrackets';
  SYNS_FriendlyAttrSquareBrackets = 'SquareBrackets';
  SYNS_AttrWeight = 'Weight';
  SYNS_FriendlyAttrWeight = 'Weight';

const
  // as this language is case-insensitive keywords *must* be in lowercase
  KeyWords: array[0..0] of string = (
    'lora' 
  );

  KeyIndices: array[0..1] of Integer = (
    0, -1 
  );

procedure TSynSDPromptSyn.InitIdent;
var
  i: Integer;
begin
  for i := Low(fIdentFuncTable) to High(fIdentFuncTable) do
    if KeyIndices[i] = -1 then
      fIdentFuncTable[i] := AltFunc;

  fIdentFuncTable[0] := FuncLora;
end;

{$Q-}
function TSynSDPromptSyn.HashKey(Str: PWideChar): Cardinal;
begin
  Result := 0;
  while IsIdentChar(Str^) do
  begin
    Result := Result + Ord(Str^);
    inc(Str);
  end;
  Result := Result mod 2;
  fStringLen := Str - fToIdent;
end;
{$Q+}

function TSynSDPromptSyn.FuncLora(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynSDPromptSyn.AltFunc(Index: Integer): TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynSDPromptSyn.IdentKind(MayBe: PWideChar): TtkTokenKind;
var
  Key: Cardinal;
begin
  fToIdent := MayBe;
  Key := HashKey(MayBe);
  if Key <= High(fIdentFuncTable) then
    Result := fIdentFuncTable[Key](KeyIndices[Key])
  else
    Result := tkIdentifier;
end;

procedure TSynSDPromptSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while (FLine[Run] <= #32) and not IsLineEnd(Run) do inc(Run);
end;

procedure TSynSDPromptSyn.NullProc;
begin
  fTokenID := tkNull;
  inc(Run);
end;

procedure TSynSDPromptSyn.NumberProc;
var
  Start: Integer;
begin
  Start := Run;
  // Handle the integer part of the number
  while fLine[Run] in ['0'..'9'] do
    Inc(Run);

  // Handle fractional part (e.g., .24)
  if (fLine[Run] = '.') and (fLine[Run + 1] in ['0'..'9']) then
  begin
    Inc(Run); // Skip the period
    while fLine[Run] in ['0'..'9'] do
      Inc(Run);
  end;

  // Set token ID for numbers
  fTokenID := tkNumber;
end;

procedure TSynSDPromptSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynSDPromptSyn.DoubleParensProc;
begin
  Inc(Run, 2); // Skip both opening parentheses
  fTokenID := tkDoubleParens;
  while not (fLine[Run] in [#0, #10, #13]) do
  begin
    if (fLine[Run] = ')') and (fLine[Run + 1] = ')') then
    begin
      Inc(Run, 2);
      Break;
    end
    else if fLine[Run] = ':' then
      WeightProc
    else
      Inc(Run);
  end;
  fTokenID := tkDoubleParens;
end;

procedure TSynSDPromptSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynSDPromptSyn.LoraTagOpenProc;
begin
  Inc(Run);
  if (fLine[Run] = 'l') and
     (fLine[Run + 1] = 'o') and
     (fLine[Run + 2] = 'r') and
     (fLine[Run + 3] = 'a') and
     (fLine[Run + 4] = ':') then
  begin
    Inc(Run, 5);
    fRange := rsLoraTag;
    fTokenID := tkLora;
  end
  else
    fTokenID := tkIdentifier;
end;

procedure TSynSDPromptSyn.LoraTagProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    begin
      fTokenID := tkLora;
      repeat
        if (fLine[Run] = '>') then
        begin
          Inc(Run, 1);
          fRange := rsUnKnown;
          Break;
        end;
        if not IsLineEnd(Run) then
          Inc(Run);
      until IsLineEnd(Run);
    end;
  end;
end;

constructor TSynSDPromptSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCaseSensitive := False;

  fAngleBracketsAttri := TSynHighLighterAttributes.Create(SYNS_AttrAngleBrackets, SYNS_FriendlyAttrAngleBrackets);
  fAngleBracketsAttri.Style := [fsBold];
  fAngleBracketsAttri.Foreground := clMaroon;
  AddAttribute(fAngleBracketsAttri);

  fDoubleParensAttri := TSynHighLighterAttributes.Create(SYNS_AttrDoubleParens, SYNS_FriendlyAttrDoubleParens);
  fDoubleParensAttri.Style := [fsBold];
  fDoubleParensAttri.Foreground := clPurple;
  AddAttribute(fDoubleParensAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier, SYNS_FriendlyAttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrReservedWord, SYNS_FriendlyAttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fKeyAttri.Foreground := clBlue;
  AddAttribute(fKeyAttri);

  fLoraAttri := TSynHighLighterAttributes.Create(SYNS_AttrLora, SYNS_FriendlyAttrLora);
  fLoraAttri.Style := [fsBold];
  fLoraAttri.Foreground := clRed;
  fLoraAttri.Background := clYellow;
  AddAttribute(fLoraAttri);

  fNumberAttri := TSynHighLighterAttributes.Create(SYNS_AttrNumber, SYNS_FriendlyAttrNumber);
  fNumberAttri.Foreground := clTeal;
  AddAttribute(fNumberAttri);

  fPeriodAttri := TSynHighLighterAttributes.Create(SYNS_AttrPeriod, SYNS_FriendlyAttrPeriod);
  fPeriodAttri.Background := clSilver;
  AddAttribute(fPeriodAttri);

  fSeparatorAttri := TSynHighLighterAttributes.Create(SYNS_AttrSeparator, SYNS_FriendlyAttrSeparator);
  fSeparatorAttri.Background := clWhite;
  AddAttribute(fSeparatorAttri);

  fSingleParensAttri := TSynHighLighterAttributes.Create(SYNS_AttrSingleParens, SYNS_FriendlyAttrSingleParens);
  fSingleParensAttri.Style := [fsBold];
  fSingleParensAttri.Foreground := clNavy;
  AddAttribute(fSingleParensAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace, SYNS_FriendlyAttrSpace);
  AddAttribute(fSpaceAttri);

  fSquareBracketsAttri := TSynHighLighterAttributes.Create(SYNS_AttrSquareBrackets, SYNS_FriendlyAttrSquareBrackets);
  fSquareBracketsAttri.Style := [fsBold];
  fSquareBracketsAttri.Foreground := clGreen;
  AddAttribute(fSquareBracketsAttri);

  fWeightAttri := TSynHighLighterAttributes.Create(SYNS_AttrWeight, SYNS_FriendlyAttrWeight);
  fWeightAttri.Foreground := clRed;
  AddAttribute(fWeightAttri);

  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  fDefaultFilter := SYNS_FilterSDPrompt;
  fRange := rsUnknown;
end;

procedure TSynSDPromptSyn.AngleBracketsProc;
begin
  Inc(Run);
//  while (fLine[Run] <> '>') and (fLine[Run] <> #0) do Inc(Run);
  while not (fLine[Run] in ['>', #0, #10, #13]) do // improving loop trap
  begin
    if fLine[Run] = ':' then
      WeightProc
    else
      Inc(Run);
  end;
  if fLine[Run] = '>' then Inc(Run);
  fTokenID := tkAngleBrackets; // improving loop trap
end;

procedure TSynSDPromptSyn.IdentProc;
begin
//  while fLine[Run] in ['0'..'9', '.'] do Inc(Run);
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while IsIdentChar(fLine[Run]) do
    inc(Run);
end;

procedure TSynSDPromptSyn.PeriodProc;
begin
  Inc(Run);
end;

procedure TSynSDPromptSyn.SeparatorProc;
begin
  Inc(Run);
end;

procedure TSynSDPromptSyn.SingleParensProc;
begin
  Inc(Run);
  //while (fLine[Run] <> ')') and (fLine[Run] <> #0) do Inc(Run);
  while not (fLine[Run] in [')', #0, #10, #13]) do
  begin
    if fLine[Run] = ':' then
      WeightProc
    else
      Inc(Run);
  end;
  if fLine[Run] = ')' then Inc(Run);
  fTokenID := tkSingleParens;
end;

procedure TSynSDPromptSyn.SquareBracketsProc;
begin
  Inc(Run);
while (fLine[Run] <> ']') and (fLine[Run] <> #0) do Inc(Run);
if fLine[Run] = ']' then Inc(Run);
end;

procedure TSynSDPromptSyn.WeightProc;
begin
  Inc(Run);

  if fLine[Run] in ['0'..'9'] then
  begin
    NumberProc;
    fTokenID := tkWeight;
  end
  else
    fTokenID := tkUnknown;
//while fLine[Run] in ['0'..'9', '.'] do Inc(Run);
end;

procedure TSynSDPromptSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynSDPromptSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsLoraTag: LoraTagProc;
  else
    case fLine[Run] of
      #0: NullProc;
      #10: LFProc;
      #13: CRProc;
//      '<': LoraTagOpenProc;
      '<': AngleBracketsProc;
      #1..#9, #11, #12, #14..#32: SpaceProc;
      'A'..'Z', 'a'..'z', '_': IdentProc;
      '0'..'9': NumberProc; // added appart than SynGen
      '.':
        if fLine[Run + 1] in ['0'..'9'] then
          NumberProc
        else
          PeriodProc;
      ',': SeparatorProc;
      '(':
        if fLine[Run + 1] = '(' then
          DoubleParensProc
        else
          SingleParensProc;
      '[': SquareBracketsProc;
      ':': WeightProc;
    else
      UnknownProc;
    end;
  end;

  // Ensure no infinite loop
  if Run >= fLineLen then
    fTokenID := tkNull;
  //inherited;
end;

function TSynSDPromptSyn.GetDefaultAttribute(Index: Integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
  else
    Result := nil;
  end;
end;

function TSynSDPromptSyn.GetEol: Boolean;
begin
  Result := Run = fLineLen + 1;
end;

function TSynSDPromptSyn.GetKeyWords(TokenKind: Integer): string;
begin
  Result := 
    'lora';
end;

function TSynSDPromptSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynSDPromptSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkAngleBrackets: Result := fAngleBracketsAttri;
    tkDoubleParens: Result := fDoubleParensAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkLora: Result := fLoraAttri;
    tkNumber: Result := fNumberAttri;
    tkPeriod: Result := fPeriodAttri;
    tkSeparator: Result := fSeparatorAttri;
    tkSingleParens: Result := fSingleParensAttri;
    tkSpace: Result := fSpaceAttri;
    tkSquareBrackets: Result := fSquareBracketsAttri;
    tkWeight: Result := fWeightAttri;
    tkUnknown: Result := fIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TSynSDPromptSyn.GetTokenKind: Integer;
begin
  Result := Ord(fTokenId);
end;

function TSynSDPromptSyn.IsIdentChar(AChar: WideChar): Boolean;
begin
  case AChar of
    {'',} '0'..'9', 'a'..'z', 'A'..'Z':
      Result := True;
    else
      Result := False;
  end;
end;

function TSynSDPromptSyn.GetSampleSource: string;
begin
  Result := 
    'a beautiful landscape, (detailed), ((highly detailed)), [quality:1.2], <lora:landscape:0.8>''trees and mountains in the background, gentle sunset. dramatic lighting';
end;

function TSynSDPromptSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterSDPrompt;
end;

class function TSynSDPromptSyn.GetFriendlyLanguageName: string;
begin
  Result := SYNS_FriendlyLangSDPrompt;
end;

class function TSynSDPromptSyn.GetLanguageName: string;
begin
  Result := SYNS_LangSDPrompt;
end;

procedure TSynSDPromptSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynSDPromptSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynSDPromptSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

initialization
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynSDPromptSyn);
{$ENDIF}
end.*)
