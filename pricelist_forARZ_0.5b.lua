script_author('yummy')
script_name('Pricelist for Arizona RP')
script_moonloader(026)
script_version("0.5b")
script_description("redesign")

require 'lib.moonloader'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local rkeys = require 'rkeys'
imgui.HotKey = require('imgui_addons').HotKey
local inicfg = require 'inicfg'
local allKeys = "moonloader/resource/settings.ini"

local cars = "moonloader/resource/prices/cars.ini"
local skins = "moonloader/resource/prices/skins.ini"
local accessories = "moonloader/resource/prices/accessories.ini"
local moto = "moonloader/resource/prices/moto.ini"
local other = "moonloader/resource/prices/other.ini"

------------------ keys -------------------
local loadKeys = inicfg.load(nil, allKeys)
local tLastKeys = {}
if loadKeys.settings == nil then 
    loadKeys.settings = {
        key1 = "[18,83]"
    }
end
local ActiveMenu = {
	v = decodeJson(loadKeys.settings.key1)
}

--------------------------- imgui Windows ------------------------------
show_main_window = imgui.ImBool(false)
local show_cars_price = imgui.ImBool(false)
local show_skin_price = imgui.ImBool(false)
local show_accs_price = imgui.ImBool(false)
local show_bicycle_price = imgui.ImBool(false)
local show_moto_price = imgui.ImBool(false)
local show_other_price = imgui.ImBool(false)
local show_helicopter_price = imgui.ImBool(false)
local show_setting_menu = imgui.ImBool(false)
local editPrice = imgui.ImBool(false)
local inputBufferText = imgui.ImBuffer(256)
local editCars = imgui.ImBool(false)
local editSkins = imgui.ImBool(false)
local editAcs = imgui.ImBool(false)
local editMoto = imgui.ImBool(false)
local editOther = imgui.ImBool(false)




-------------------------------- theme ----------
function BlackTheme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
BlackTheme()
------- icons --------
local icons = require 'fAwesome5'
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ icons.min_range, icons.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() 
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end
-----------imgui----------------
function imgui.OnDrawFrame()
        if show_main_window.v then
            imgui.SetNextWindowSize(imgui.ImVec2(200, 250), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowPos(imgui.ImVec2(150,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.Begin('pricelist_forARZ_0.5b', show_main_window, imgui.WindowFlags.NoResize)
            local btn_size = imgui.ImVec2(-0.1, 0)
            if imgui.Button(icons.ICON_FA_CAR..u8' Авто',btn_size) then
            show_cars_price.v = not show_cars_price.v
            end
            if imgui.Button(icons.ICON_FA_TSHIRT..u8' Скины',btn_size) then
            show_skin_price.v = not show_skin_price.v
            end
            if imgui.Button(icons.ICON_FA_HAT_WIZARD..u8' Аксессуары', btn_size) then 
            show_accs_price.v = not show_accs_price.v
            end
            if imgui.Button(icons.ICON_FA_BICYCLE..u8' Велотранспорт', btn_size) then 
                show_bicycle_price.v = not show_bicycle_price.v
            end
            if imgui.Button(icons.ICON_FA_MOTORCYCLE..u8' Мототранспорт', btn_size) then 
                show_moto_price.v = not show_moto_price.v
            end
            if imgui.Button(icons.ICON_FA_GIFT..u8' Остальное', btn_size) then 
                show_other_price.v = not show_other_price.v
            end
            if imgui.Button(icons.ICON_FA_PLANE..u8' Воздушный транспорт', btn_size) then 
                show_helicopter_price.v = not show_helicopter_price.v
            end
            if imgui.Button(icons.ICON_FA_COGS..u8' Настройки скрипта', btn_size) then 
                show_setting_menu.v = not show_setting_menu.v
            end
            -- if imgui.Button(icons.ICON_FA_PEN..u8' Редактор цен', btn_size) then 
            --     editPrice.v = not editPrice.v
            -- end
end

--InputText

----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------
----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------
----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------
----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------

    if show_cars_price.v then
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((250), 700), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Авто', show_cars_price, imgui.WindowFlags.NoResize)
        local loadCars = inicfg.load(nil, cars)
        imgui.Columns(2,"Cars", true)
            imgui.Separator()
            imgui.Text(u8"Название:")
            imgui.NextColumn()
            imgui.Text(u8"Цена:")
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"LVPD car")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.lvpd))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotring A")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.hotA))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotring B")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.hotB))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotring C")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.hotC))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Infernus")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.infernus))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Bullet")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.bullet))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Turismo")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.turismo))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Sultan")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.sultan))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Cheetah")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.cheetah))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Jester")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.jester))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Banshee")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.banshee))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Super GT")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.supergt))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Comet")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.comet))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hantley")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.hantley))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Buffalo")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.buffalo))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Slawman")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.slawman))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Alpha")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.alpha))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Yosemite")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.yosemite))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"ZR-350")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.zr350))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotknife")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.hotknife))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Uranus")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.uranus))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Stallion")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.stallion))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Elegy")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.elegy))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Sandking")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.sandking))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Tahoma")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.tahoma))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Flash")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.flash))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Phoenix")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.phoenix))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Landstalker")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.landstalker))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Feltzer")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.feltzer))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Mesa")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.mesa))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Rancher")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.rancher))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Washitgton")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.prices.washington))
            imgui.NextColumn()
            imgui.Columns(1)
            imgui.Separator()
        imgui.End()
    end    
    if show_skin_price.v then
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((330), 320), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Скины', show_skin_price, imgui.WindowFlags.NoResize)
        local loadSkins = inicfg.load(nil, skins)
        imgui.Columns(2,"Skins", true)
        imgui.Text(u8"Печень Ацтек(114 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.aztec114))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Вагос(108 id")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.vagos108))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Рифа(175 id")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.rifa175))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Лидер ЛКН(113 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.lkn113))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Грув(105 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.groove105))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Баллас(103id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.ballas103))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"BMXer")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.bmx))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Конор")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.conor))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин РМ(112 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.rm112))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин Якудза(122 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.yakuza122))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин ЛКН(124 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.lkn124))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин Байкеры(181 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.biker181))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Крупье(красный, чёрный)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.prices.stickmanBlackAndRed))
        imgui.NextColumn()
        imgui.Columns(1)
        imgui.Separator()
        imgui.End()
    end
    if show_accs_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((370), 700), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Аксессуары', show_accs_price, imgui.WindowFlags.NoResize)
        local loadAcs = inicfg.load(nil, accessories)
        imgui.Columns(2,"Accessories", true)
            imgui.Separator()
            imgui.Text(u8"Название:")
            imgui.SameLine(105)
            imgui.NextColumn()
            imgui.Text(u8"Цена:")
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бумбокс")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.boombox))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Цилиндр белый/черный")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.cylinderBlackWhite))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Уник.чемодан")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.unikSuitcases))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Сумка для ноутбука")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.sNotebook))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Маска демона")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.demonmask))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Гитара(все виды)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.guitar))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Красный кейс")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.redcase))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Голова зомби")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.zombiehead))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Подарок на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.podarokForBack))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Голова сиджея")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.CJhead))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Голова сиджея(цветная)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorCJhead))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бита с Шипами")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.nailsBit))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Хокейная маска")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.hockeymask))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Хокейная маска(цветная)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorHockeyMask))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бита")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.bit))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бита цветная")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorBit))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Рюкзак с шипами")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.backpackThorns))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Рюкзак террориста")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.backpackTerrorist))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Метла")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.broom))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Очки Ночного Видения (ПНВ)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.nightvisionglasses))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Рога")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.horns))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Скейт")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.skate))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Черная колонка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.blackspeaker))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Дреды")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.dreadlocks))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Попугай на плечо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.kesha))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Петух на плечо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.brooks))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Елка на плечо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.tree))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Хот-Дог на голову")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.hotdog))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Гамбургер на голову")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.hamburger))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Лопата на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.shovel))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Мешок с мясом")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.meatbag))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Мешок с мясом(цветной)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorMeatBag))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Миниган на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.minigun))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Сковорода на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.pan))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Крест на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.cross))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Сердце на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.heart))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Череп на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.skull))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Рубашка на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.shirt))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Кирка на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.pickaxe))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Грабли на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.rake))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Меч на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.sword))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Меч на спину(цветной)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorSword))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Шлем спецназа")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.helmet))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Повязка на шею")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.bandage))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Молот на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.hammer))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Щит на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.shield))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Щит на спину (цветной)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorShield))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Доска для серфа")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.surfboard))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Дилдо на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.dildo))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Катана")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.katana))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Катана(цветная)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorkatana))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Респиратор")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.respirator))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Пасхальное яйцо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.easterEggs))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Огнетушитель")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.fireExtin))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Огнемет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.firegun))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Балонный ключ")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.ballonkey))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Улучшенный бронежилет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.upgArmour))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Шар")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.flyBall))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Нимб")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.numbus))
            imgui.NextColumn()
            imgui.Separator()
                        
            imgui.Text(u8"Голова быка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.bullHead))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Шляпа мага")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.wizardHead))
            imgui.NextColumn()
            imgui.Separator()
            

            imgui.Text(u8"Шлем")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.stockhelmet))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Амулет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.amulet))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Цветной амулет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorAmulet))
            imgui.NextColumn()
            imgui.Separator()
                        
            imgui.Text(u8"Бензопила на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.chainsaw))
            imgui.NextColumn()
            imgui.Separator()
        
            imgui.Text(u8"Новогодняя шапка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.newyearHead))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Веер на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.fan))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Устрица на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.oysters))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Кий на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.cue))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Переносной ларек(Нарко)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.narkoLarek))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Пепеносной ларек(Фрукты)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.fruitLarek))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Переносной ларек(Доллар)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.dollarLarek))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Костюм попугая")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.parrotCostume))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Машинка на р/у")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.carRC))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Фотоаппарат на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.photo))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Рыба на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.fish))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Звезда на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.star))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Жилет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.vest))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Жилет цветной")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.prices.colorVest))
            imgui.NextColumn()
            imgui.Separator()  
        -- imgui.Text(u8"")
        -- imgui.NextColumn()
        -- imgui.Text(string.format("%s$", loadAcs.prices.guitar))
        -- imgui.NextColumn()
        -- imgui.Separator()
        imgui.End()
    end
    if show_bicycle_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((250), 250), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Велотранспорт', show_bicycle_price, imgui.WindowFlags.NoResize)
        imgui.Text(u8[[
        in coming soon...
        ]])
        imgui.End()
    end
    if show_moto_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((350), 225), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Мототранспорт', show_moto_price, imgui.WindowFlags.NoResize)
        loadMoto = inicfg.load(nil, moto)
        imgui.Columns(3,"Moto", true)
            imgui.Separator()
            imgui.Text(u8"Название:")
            imgui.NextColumn()
            imgui.Text(u8"ID:")
            imgui.NextColumn()
            imgui.Text(u8"Цена:")
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Freeway")
            imgui.NextColumn()
            imgui.Text(u8"463")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.freeway))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"PCJ-600")
            imgui.NextColumn()
            imgui.Text(u8"461")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.pcj600))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"FCR-900")
            imgui.NextColumn()
            imgui.Text(u8"521")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.fcr900))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Quad")
            imgui.NextColumn()
            imgui.Text(u8"471")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.quad))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"NRG-500")
            imgui.NextColumn()
            imgui.Text(u8"522")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.nrg500))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Sanchez")
            imgui.NextColumn()
            imgui.Text(u8"468")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.sanchez))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"BF-400")
            imgui.NextColumn()
            imgui.Text(u8"581")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.prices.bf400))
            imgui.NextColumn()
            imgui.Columns(1)
            imgui.Separator()
        imgui.End()
    end
    if show_other_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((310), 280), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Остальное', show_other_price)
        local loadOther = inicfg.load(nil, other)
        imgui.Columns(2,'Other', true)
            imgui.Text(u8"Семейные талоны")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.famtalon))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Подарки")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.podarok))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Гражданские талоны")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.grtalon))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Твин-Турбо"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.twinT))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Хеллоуин"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.helloween))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8' Набор "Футуристик"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.futuristic))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Новый год"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.newyear))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Золотая рулетка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.gold))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Серебрянная рулетка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.silver))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бронзовая рулетка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.bronze))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Лавка на ЦР(по центру)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.prices.lavka))
            imgui.NextColumn()
            imgui.Columns(1)
            imgui.Separator()
        imgui.End()    
    end
    -----------------------------Поздравляю, говнокод кончился-----------------------------------------------
    -----------------------------Поздравляю, говнокод кончился-----------------------------------------------
    -----------------------------Поздравляю, говнокод кончился-----------------------------------------------
    if show_helicopter_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((250), 250), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Воздушный транспорт', show_helicopter_price, imgui.WindowFlags.NoResize)
        imgui.Text(u8[[
        in coming soon...
        ]])
        imgui.End()    
    end
    if show_setting_menu.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((280), 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Настройки скрипта', show_setting_menu,  imgui.WindowFlags.NoResize)
        imgui.Text(u8'Изменить активацию:')
        if imgui.HotKey("##one", ActiveMenu, tLastKeys, btn_size) then
        rkeys.changeHotKey(key1, ActiveMenu.v)
        loadKeys.settings.key1 = encodeJson(ActiveMenu.v)
        inicfg.save(loadKeys, allKeys)
        end
        imgui.End() 
    end 
    if editPrice.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((280),250), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Редактор цен', editPrice,  imgui.WindowFlags.NoResize)
        imgui.SameLine(80)

        imgui.Text(u8'Выберите категорию:')
        imgui.Separator()
        local btn_size = imgui.ImVec2(-0.1, 0)
        if imgui.Button(u8'Мото', btn_size) then 
            editMoto.v = not editMoto.v
        end
        if imgui.Button(u8'Скины', btn_size) then 
            editSkins.v = not editSkins.v
        end
        if imgui.Button(u8'Авто', btn_size) then 
            editCars.v = not editCars.v
        end
        if imgui.Button(u8'Аксессуары', btn_size) then 
            editAcs.v = not editAcs.v
        end
        if imgui.Button(u8'Мото', btn_size) then 
            editMoto.v = not editMoto.v
        end
        imgui.End()
        end 
    imgui.End()
end

function main()
    if not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage([[{DC143C}[0.5beta]{FFFFFF}Special for Dream Dynasty ]], -1)  
    key1 = rkeys.registerHotKey(ActiveMenu.v, true, function ()
        show_main_window.v = not show_main_window.v
        
    end)
    sampAddChatMessage("{DC143C}Активация: {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveMenu.v), "+"), -1)  
	while true do
		wait(0)
        imgui.Process = show_main_window.v
	end
end
