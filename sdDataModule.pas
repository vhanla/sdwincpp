unit sdDataModule;

interface

uses
  System.SysUtils, System.Classes, SynSpellCheck, Vcl.StdActns, System.Actions,
  Vcl.ActnList, SynEditHighlighter, SynEditCodeFolding, SynHighlighterPas,
  SynHighlighterXML, Vcl.Graphics;

type
  TCommandsDataModule = class(TDataModule)
    SynSpellCheck: TSynSpellCheck;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    actSynSpellCheckFile: TSynSpellCheckFile;
    actSynSpellCheckLine: TSynSpellCheckLine;
    actSynSpellCheckSelection: TSynSpellCheckSelection;
    actSynSpellCheckWord: TSynSpellCheckWord;
    actSynSpellClearErrors: TSynSpellClearErrors;
    actSynSpellCheckAsYouType: TSynSpellCheckAsYouType;
    actSynSpellErrorAdd: TSynSpellErrorAdd;
    actSynSpellErrorIgnoreOnce: TSynSpellErrorIgnoreOnce;
    actSynSpellErrorIgnore: TSynSpellErrorIgnore;
    actSynSpellErrorDelete: TSynSpellErrorDelete;
    SynXMLSyn1: TSynXMLSyn;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDefaultTheme;
    procedure SetDarkTheme;
  end;

var
  CommandsDataModule: TCommandsDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TCommandsDataModule.DataModuleCreate(Sender: TObject);
begin
  SynSpellCheck.LanguageCode := 'en-US';
//  SetDarkTheme;
end;

procedure TCommandsDataModule.SetDarkTheme;
begin
 with SynXMLSyn1 do
  begin
    // Background Color
    //Color := $282A36; // Dark background

    // Attributes
    AttributeAttri.Foreground := $50FA7B; // Greenish for attribute names
    AttributeValueAttri.Foreground := $F1FA8C; // Yellowish for attribute values

    // CDATA
    CDATAAttri.Foreground := $F1FA8C; // Yellowish

    // Comments
    CommentAttri.Foreground := $6272A4; // Grayish blue for comments

    // DocType
    DocTypeAttri.Foreground := $8BE9FD; // Light blue

    // Elements
    ElementAttri.Foreground := $FF79C6; // Pinkish for element names

    // Entity References
    EntityRefAttri.Foreground := $8BE9FD; // Light blue

    // Namespaces
    NamespaceAttributeAttri.Foreground := $FF5555; // Reddish
    NamespaceAttributeValueAttri.Foreground := $FF5555; // Reddish

    // Processing Instructions
    ProcessingInstructionAttri.Foreground := $8BE9FD; // Light blue

    // Spaces (optional, might not be necessary)
    SpaceAttri.Foreground := clNone;

    // Symbols
    SymbolAttri.Foreground := $8BE9FD; // Light blue

    // Text Content
    TextAttri.Foreground := $F8F8F2; // Off-white for text content
  end;
end;

procedure TCommandsDataModule.SetDefaultTheme;
begin
  with SynXMLSyn1 do
  begin
    AttributeAttri.Foreground := clMaroon;
    AttributeValueAttri.Foreground := clNavy;
    CDATAAttri.Foreground := clOlive;
    CommentAttri.Foreground := clGray;
    DocTypeAttri.Foreground := clBlue;
    ElementAttri.Foreground := clMaroon;
    EntityRefAttri.Foreground := clBlue;
    NamespaceAttributeAttri.Foreground := clRed;
    NamespaceAttributeValueAttri.Foreground := clRed;
    ProcessingInstructionAttri.Foreground := clBlue;
    SpaceAttri.Foreground := clNone;
    SymbolAttri.Foreground := clBlue;
    TextAttri.Foreground := clBlack;
  end;
end;

end.
