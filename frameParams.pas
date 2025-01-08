unit frameParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACL.UI.Controls.Buttons,
  ACL.UI.Controls.Base, ACL.UI.Controls.GroupBox, ACL.UI.Controls.TextEdit,
  ACL.UI.Controls.ImageComboBox, ACL.UI.Controls.Slider,
  ACL.UI.Controls.BaseEditors, ACL.UI.Controls.DropDown,
  ACL.UI.Controls.ComboBox, ACL.UI.Controls.Labels, ACL.UI.Controls.Panel,
  ACL.Classes, ACL.UI.Resources, System.ImageList, Vcl.ImgList,
  SVGIconImageListBase, SVGIconImageList;

type
  TframeParameters = class(TFrame)
    ACLSidebar: TACLPanel;
    ACLLabel1: TACLLabel;
    ACLLabel2: TACLLabel;
    ACLComboBox1: TACLComboBox;
    ACLComboBox2: TACLComboBox;
    ACLSlider1: TACLSlider;
    ACLGroupBox2: TACLGroupBox;
    ACLImageComboBox2: TACLImageComboBox;
    ACLCheckBox1: TACLCheckBox;
    ACLCheckBox2: TACLCheckBox;
    ACLSlider4: TACLSlider;
    gbImageSize: TACLGroupBox;
    aclsliderHeight: TACLSlider;
    aclsliderWidth: TACLSlider;
    aclComboAspectRatio: TACLImageComboBox;
    ACLImageComboBox4: TACLImageComboBox;
    ACLGroupBox3: TACLGroupBox;
    ACLImageComboBox3: TACLImageComboBox;
    ACLEdit1: TACLEdit;
    ACLResourceCollection1: TACLResourceCollection;
    SVGIconImageList1: TSVGIconImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
