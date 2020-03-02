// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_CHECKBOX         77

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// Default grid
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

// Pixel grid
#define pixelScale	0.50
#define GRID_W (pixelW * pixelGrid * pixelScale)
#define GRID_H (pixelH * pixelGrid * pixelScale)

class RscText_RRR
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = ST_LEFT;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "RobotoCondensed";
	SizeEx = GUI_TEXT_SIZE_MEDIUM;
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class RscPicture_RRR
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	style = ST_MULTI + ST_TITLE_BAR;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class RscButton_RRR
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_BUTTON;
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0,0,0,1};
	colorFocused[] = {0,0,0,1};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,1};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	idc = -1;
	style = ST_CENTER;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	url = "";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};
class RscPictureKeepAspect_RRR: RscPicture_RRR
{
	style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
};
class RscShortcutButton_RRR
{
	deletable = 0;
	fade = 0;
	type = CT_SHORTCUTBUTTON;
	x = 0.1;
	y = 0.1;
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0;
		top = ((GUI_GRID_HAbs / 20) - GUI_TEXT_SIZE_MEDIUM) / 2;
		w = GUI_TEXT_SIZE_MEDIUM * (3/4);
		h = GUI_TEXT_SIZE_MEDIUM;
	};
	class TextPos
	{
		left = GUI_TEXT_SIZE_MEDIUM * (3/4);
		top = ((GUI_GRID_HAbs / 20) - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1,1,1,1};
	colorFocused[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	colorBackgroundFocused[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	colorBackground2[] = {1,1,1,1};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = ST_LEFT;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = (GUI_GRID_HAbs / 20);
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {1,1,1,1};
	color2Secondary[] = {0.95,0.95,0.95,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = GUI_TEXT_SIZE_MEDIUM;
	fontSecondary = "RobotoCondensed";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "RobotoCondensed";
	size = GUI_TEXT_SIZE_MEDIUM;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	text = "";
	url = "";
	action = "";
	class AttributesImage
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
	};
};
class RscButtonMenu_RRR: RscShortcutButton_RRR
{
	idc = -1;
	type = CT_SHORTCUTBUTTON;
	style = ST_CENTER + ST_FRAME + ST_HUD_BACKGROUND;
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {0,0,0,1};
	color2Secondary[] = {0,0,0,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = GUI_TEXT_SIZE_MEDIUM;
	fontSecondary = "PuristaLight";
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = GUI_TEXT_SIZE_MEDIUM;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = 0.25 * GUI_GRID_W;
		top = (GUI_GRID_H - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	class Attributes
	{
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = 5.25 * GUI_GRID_W;
		top = 0;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",
		0.09,
		1
	};
};
class RscButtonMenuOK_RRR: RscButtonMenu_RRR
{
	idc = 1;
	shortcuts[] =
	{
		"0x00050000 + 0",
		28,
		57,
		156
	};
	default = 1;
	text = "OK";
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",
		0.09,
		1
	};
};
class RscButtonMenuCancel_RRR: RscButtonMenu_RRR
{
	idc = 2;
	shortcuts[] =
	{
		"0x00050000 + 1"
	};
	text = "Cancel";
};
class RscStructuredText_RRR
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STRUCTURED_TEXT;
	idc = -1;
	style = ST_LEFT;
	colorText[] = {1,1,1,1};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		colorLink = "#D09B43";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = GUI_TEXT_SIZE_MEDIUM;
	shadow = 1;
};
class RscFrame_RRR
{
	type = CT_STATIC;
	idc = -1;
	deletable = 0;
	style = ST_FRAME;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "RobotoCondensed";
	sizeEx = 0.02;
	text = "";
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
};
/*
class ScrollBar
{
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
	scrollSpeed = 0.06;
	width = 0;
	height = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};
*/
class RscCombo_RRR
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_COMBO;
	colorSelect[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	colorScrollbar[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundSelect",
		0.1,
		1
	};
	soundExpand[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundExpand",
		0.1,
		1
	};
	soundCollapse[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundCollapse",
		0.1,
		1
	};
	maxHistoryDelay = 1;
	class ComboScrollBar: ScrollBar
	{
		color[] = {1,1,1,1};
	};
	style = ST_MULTI + ST_NO_RECT;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	colorSelectBackground[] = {1,1,1,0.7};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	colorActive[] = {1,0,0,1};
};
class rearmVehicledialog
{
    idd = 0720;
    onLoad = "uiNamespace setVariable ['rearmVehicledialog', _this select 0]; []spawn RRR_onLoadRearmDialog;";
    movingenable=false;
    class Controls
    {
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT START (by Ghostrider, v1.063, #Sunobo)
        ////////////////////////////////////////////////////////

        class background: RscFrame_RRR
        {
            idc = 1800;
            x = 0.270833 * safezoneW + safezoneX;
            y = 0.225 * safezoneH + safezoneY;
            w = 0.458333 * safezoneW;
            h = 0.627 * safezoneH;
            //colorText[] = {0,0,0,0.1};
            colorBackground[] = {0.5,0.5,0.5,0.5};            
            style = ST_BACKGROUND;
        };
    
        class Title: RscText_RRR
        {
            idc = 1002;
            text = "SERVICE POINT";  
            style = ST_CENTER;
            x = 0.270833 * safezoneW + safezoneX;
            y = 0.192 * safezoneH + safezoneY;
            w = 0.458333 * safezoneW;
            h = 0.044 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,1};
        };
        class vehPic: RscPictureKeepAspect_RRR
        {
            idc = 1200;
            text = "#(argb,8,8,3)color(1,1,1,1)";
            x = 0.328125 * safezoneW + safezoneX;
            y = 0.291 * safezoneH + safezoneY;
            w = 0.349479 * safezoneW;
            h = 0.451 * safezoneH;
             colorBackground[] = {1,1,1,1};
        };
        
        class Cancel_2700: RscButtonMenuCancel_RRR
        {
            x = 0.276563 * safezoneW + safezoneX;
            y = 0.621 * safezoneH + safezoneY;
            w = 0.0458333 * safezoneW;
            h = 0.033 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};
            colorBackgroundActive[] = {0.35,0.35,0.1,0.8};
        };
        /*
        class OK_2600: RscButton
        {
            x = 0.276563 * safezoneW + safezoneX;
            y = 0.676 * safezoneH + safezoneY;
            w = 0.0458333 * safezoneW;
            h = 0.033 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};
            colorBackgroundActive[] = {0.35,0.35,0.1,0.8};            
            // need to add an action here that executes the rearm.
        };
        */
        #define comboWidth 0.15 * safezoneW
        class loadoutOne: RscCombo_RRR
        {
            idc = 2100;
            x = 0.161979 * safezoneW + safezoneX;
            y = 0.247 * safezoneH + safezoneY;
            //w = 0.103125 * safezoneW;
            w = comboWidth;
            h = 0.044 * safezoneH;
            onLBSelChanged = "call RRR_loadoutSelectionChanged;";
        };
        
        class loadoutTwo: RscCombo_RRR
        {
            idc = 2101;
            x = 0.161979 * safezoneW + safezoneX;
            y = 0.302 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutThree: RscCombo_RRR
        {
            idc = 2102;
            x = 0.161979 * safezoneW + safezoneX;
            y = 0.357 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutFour: RscCombo_RRR
        {
            idc = 2103;
            x = 0.161979 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutFive: RscCombo_RRR
        {
            idc = 2104;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.247 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutSix: RscCombo_RRR
        {
            idc = 2105;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.302 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutSeven: RscCombo_RRR
        {
            idc = 2106;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.357 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutEight: RscCombo_RRR
        {
            idc = 2107;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutNine: RscCombo_RRR
        {
            idc = 2108;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutTen: RscCombo_RRR
        {
            idc = 2109;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutEleven: RscCombo_RRR
        {
            idc = 2110;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutTwelve: RscCombo_RRR
        {
            idc = 2111;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutThirteen: RscCombo_RRR
        {
            idc = 2112;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };
        class loadoutFourteen: RscCombo_RRR
        {
            idc = 2113;
            x = 0.740625 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = comboWidth;
            h = 0.044 * safezoneH;
           onLBSelChanged = "call RRR_loadoutSelectionChanged;";            
        };												
        class refuel: RscButton_RRR
        {
            idc = 1600;
            text = "Refuel";  
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};
            colorBackgroundActive[] = {0.35,0.35,0.1,0.8};              
			action = "closeDialog 0; call RRR_doVehicleRefuelDialog;";
            tooltip = "Refuel";
            onMouseEnter = "call RRR_updateCtrlRefuelPrice;";
            onMouseExit = "call RRR_hidePriceControl;";            
        };
        class reapir: RscButton_RRR
        {
            idc = 1601;
            text = "Repair";  
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};   
            colorBackgroundActive[] = {0.35,0.35,0.1,0.8};                       
			action = "closeDialog 0; call RRR_doVehicleRepairDialog;";
            tooltip = "Repair";	
            onMouseEnter = "call RRR_updateCtrlRepairPrice;";  
            onMouseExit = "call RRR_hidePriceControl;";                      
        };
        class vehClassname: RscText_RRR
        {
            idc = 1003;
            text = "ToDo: Localize"; 
            style = ST_CENTER;            
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.177604 * safezoneW;
			h = 0.033 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,1};
        };
		class defaultsRearm: RscButton_RRR
		{
			idc = 1602;
			action = "closeDialog 0; call RRR_doVehicleRearmDialog;";

			text = "Rearm";  
            tooltip = "Rearm with Default Loadout";
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};   
            colorBackgroundActive[] = {0.35,0.35,0.1,0.8};                       
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.055 * safezoneH;
            onMouseEnter = "call RRR_updateCtrlRearmPrice;";
            onMouseExit = "call RRR_hidePriceControl;";
		};		
		class setLoadout: RscButton_RRR
		{
			idc = 1603;
			action = "call RRR_enableCustomizedLoadout;";
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};
            colorBackgroundActive[] = {0.35,0.35,0.1,0.8};              
			text = "Loadout";  
            tooltip = "Customize Loadout";
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.055 * safezoneH;
		};	
        class RscPicture_1201: RscPicture_RRR  //  GRG Icon
        {
            idc = 1201;
            text = "addons\watermarks\Watermark5.paa";
            //text = "#(argb,8,8,3)color(1,1,1,1)";            
            x = 0.643229 * safezoneW + safezoneX;
            y = 0.72 * safezoneH + safezoneY;
            w = 0.0744792 * safezoneW;
            h = 0.11 * safezoneH;
            //colorBackground[] = {0,0,0,1};
        };        	
        class cost: RscStructuredText_RRR
        {
            idc = 1100;
            colorText[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0.8};            
            x = 0.276563 * safezoneW + safezoneX;
            y = 0.775 * safezoneH + safezoneY;
            w = 0.20 * safezoneW;
            h = 0.044 * safezoneH;
            stle = ST_WITH_RECT;
            text = "Rearm/Repair/Refuel Cost (Tabs)";
        };        
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT END
        ////////////////////////////////////////////////////////
        
    };
};
