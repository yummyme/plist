script_author('yummy')
script_name('Pricelist for Arizona RP')
script_moonloader(026)
script_version("0.6b")
script_description("")




require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local update_url =  'https://raw.githubusercontent.com/yummyme/plist/master/resource/prices/allprices.ini'
local update_path = getWorkingDirectory() .. "/resource/prices/allprices.ini"

local rkeys = require 'rkeys'
imgui.HotKey = require('imgui_addons').HotKey
local inicfg = require 'inicfg'
local allKeys = "moonloader/resource/settings.ini"
local cars = "moonloader/resource/prices/allprices.ini"
local skins = "moonloader/resource/prices/allprices.ini"
local accessories = "moonloader/resource/prices/allprices.ini"
local moto = "moonloader/resource/prices/allprices.ini"
local other = "moonloader/resource/prices/allprices.ini"
------------ ОБНОВИ version.ini при обновлении, на гитхабе!!!!! --------------------
local scriptVer = "moonloader/resource/versions.ini"
local scrV = inicfg.load(nil, scriptVer)
------------------------------links-------------------------------

local allLinks = inicfg.load(nil, allKeys)
local scriptLink = imgui.ImBuffer(allLinks.links.pscript, 256)

local iniLink = imgui.ImBuffer(allLinks.links.pini, 256)

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
--------------------------------versions------------

local oldVersIni = "moonloader/resource/prices/allprices.ini"
local iniVersion = inicfg.load(nil, oldVersIni)
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
local editCars = imgui.ImBool(false)
local editSkins = imgui.ImBool(false)
local editAcs = imgui.ImBool(false)
local editMoto = imgui.ImBool(false)
local checkUpdateScrips = imgui.ImBool(false)
local checkUpdateIni = imgui.ImBool(false)
local checkUpdate = imgui.ImBool(false)
-------------------------------- theme ----------
function RedTheme()
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
RedTheme()
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
            imgui.SetNextWindowSize(imgui.ImVec2(200, 246), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowPos(imgui.ImVec2(150,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.Begin('Pricelist for Arizona RP', show_main_window, imgui.WindowFlags.NoResize)
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
            if imgui.Button(icons.ICON_FA_PEN..u8' Меню обновлений', btn_size) then 
                checkUpdate.v = not checkUpdate.v
            end
        end
--InputText

----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------
----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------
----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------
----------------------------------------- ВНИМАНИЕ! ГОВНОКОД! --------------------------------------------------

    if show_cars_price.v then
        imgui.SetNextWindowPos(imgui.ImVec2(400,410), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
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
            imgui.Text(string.format("%s$", loadCars.cars.lvpd))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotring A")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.hotA))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotring B")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.hotB))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotring C")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.hotC))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Infernus")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.infernus))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Bullet")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.bullet))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Turismo")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.turismo))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Sultan")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.sultan))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Cheetah")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.cheetah))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Jester")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.jester))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Banshee")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.banshee))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Super GT")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.supergt))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Comet")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.comet))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hantley")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.hantley))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Buffalo")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.buffalo))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Slawman")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.slawman))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Alpha")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.alpha))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Yosemite")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.yosemite))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"ZR-350")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.zr350))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Hotknife")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.hotknife))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Uranus")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.uranus))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Stallion")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.stallion))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Elegy")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.elegy))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Sandking")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.sandking))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Tahoma")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.tahoma))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Flash")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.flash))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Phoenix")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.phoenix))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Landstalker")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.landstalker))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Feltzer")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.feltzer))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Mesa")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.mesa))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Rancher")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.rancher))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Washitgton")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadCars.cars.washington))
            imgui.NextColumn()
            imgui.Columns(1)
            imgui.Separator()
        imgui.End()
    end    
    if show_skin_price.v then
        imgui.SetNextWindowPos(imgui.ImVec2(420,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((330), 320), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Скины', show_skin_price, imgui.WindowFlags.NoResize)
        local loadSkins = inicfg.load(nil, skins)
        imgui.Columns(2,"Skins", true)
        imgui.Text(u8"Печень Ацтек(114 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.aztec114))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Вагос(108 id")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.vagos108))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Рифа(175 id")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.rifa175))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Лидер ЛКН(113 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.lkn113))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Грув(105 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.groove105))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Печень Баллас(103id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.ballas103))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"BMXer")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.bmx))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Конор")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.conor))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин РМ(112 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.rm112))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин Якудза(122 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.yakuza122))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин ЛКН(124 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.lkn124))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Скин Байкеры(181 id)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.biker181))
        imgui.NextColumn()
        imgui.Separator()
        imgui.Text(u8"Крупье(красный, чёрный)")
        imgui.NextColumn()
        imgui.Text(string.format("%s$", loadSkins.skins.stickmanBlackAndRed))
        imgui.NextColumn()
        imgui.Columns(1)
        imgui.Separator()
        imgui.End()
    end
    if show_accs_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(440,400), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
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
            imgui.Text(string.format("%s$", loadAcs.accessories.boombox))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Цилиндр белый/черный")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.cylinderBlackWhite))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Уник.чемодан")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.unikSuitcases))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Сумка для ноутбука")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.sNotebook))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Маска демона")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.demonmask))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Гитара(все виды)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.guitar))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Красный кейс")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.redcase))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Голова зомби")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.zombiehead))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Подарок на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.podarokForBack))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Голова сиджея")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.CJhead))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Голова сиджея(цветная)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorCJhead))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бита с Шипами")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.nailsBit))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Хокейная маска")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.hockeymask))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Хокейная маска(цветная)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorHockeyMask))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бита")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.bit))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бита цветная")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorBit))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Рюкзак с шипами")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.backpackThorns))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Рюкзак террориста")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.backpackTerrorist))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Метла")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.broom))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Очки Ночного Видения (ПНВ)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.nightvisionglasses))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Рога")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.horns))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Скейт")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.skate))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Черная колонка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.blackspeaker))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Дреды")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.dreadlocks))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Попугай на плечо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.kesha))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Петух на плечо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.brooks))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Елка на плечо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.tree))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Хот-Дог на голову")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.hotdog))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Гамбургер на голову")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.hamburger))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Лопата на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.shovel))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Мешок с мясом")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.meatbag))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Мешок с мясом(цветной)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorMeatBag))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Миниган на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.minigun))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Сковорода на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.pan))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Крест на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.cross))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Сердце на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.heart))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Череп на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.skull))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Рубашка на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.shirt))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Кирка на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.pickaxe))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Грабли на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.rake))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Меч на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.sword))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Меч на спину(цветной)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorSword))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Шлем спецназа")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.helmet))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Повязка на шею")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.bandage))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Молот на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.hammer))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Щит на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.shield))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Щит на спину (цветной)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorShield))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Доска для серфа")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.surfboard))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Дилдо на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.dildo))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Катана")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.katana))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Катана(цветная)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorkatana))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Респиратор")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.respirator))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Пасхальное яйцо")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.easterEggs))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Огнетушитель")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.fireExtin))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Огнемет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.firegun))
            imgui.NextColumn()
            imgui.Separator()
    
            imgui.Text(u8"Балонный ключ")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.ballonkey))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Улучшенный бронежилет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.upgArmour))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Шар")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.flyBall))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Нимб")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.numbus))
            imgui.NextColumn()
            imgui.Separator()
                        
            imgui.Text(u8"Голова быка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.bullHead))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Шляпа мага")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.wizardHead))
            imgui.NextColumn()
            imgui.Separator()
            

            imgui.Text(u8"Шлем")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.stockhelmet))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Амулет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.amulet))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Цветной амулет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorAmulet))
            imgui.NextColumn()
            imgui.Separator()
                        
            imgui.Text(u8"Бензопила на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.chainsaw))
            imgui.NextColumn()
            imgui.Separator()
        
            imgui.Text(u8"Новогодняя шапка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.newyearHead))
            imgui.NextColumn()
            imgui.Separator()
                
            imgui.Text(u8"Веер на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.fan))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Устрица на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.oysters))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Кий на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.cue))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Переносной ларек(Нарко)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.narkoLarek))
            imgui.NextColumn()
            imgui.Separator()
                    
            imgui.Text(u8"Пепеносной ларек(Фрукты)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.fruitLarek))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Переносной ларек(Доллар)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.dollarLarek))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Костюм попугая")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.parrotCostume))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Машинка на р/у")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.carRC))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Фотоаппарат на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.photo))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Рыба на спину")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.fish))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Звезда на грудь")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.star))
            imgui.NextColumn()
            imgui.Separator()
            
            imgui.Text(u8"Жилет")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.vest))
            imgui.NextColumn()
            imgui.Separator()

            imgui.Text(u8"Жилет цветной")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadAcs.accessories.colorVest))
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
        imgui.SetNextWindowPos(imgui.ImVec2(430,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((350), 225), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Велотранспорт', show_bicycle_price, imgui.WindowFlags.NoResize)
        imgui.Text(u8[[
        in coming soon...
        ]])
        imgui.End()
    end
    if show_moto_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(430,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((350), 225), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Мототранспорт', show_moto_price, imgui.WindowFlags.NoResize)
        loadMoto = inicfg.load(nil, moto)
        imgui.Columns(2,"Moto", true)
            imgui.Separator()
            imgui.Text(u8"Название:")
            imgui.NextColumn()
            imgui.Text(u8"Цена:")
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Freeway")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.freeway))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"PCJ-600")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.pcj600))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"FCR-900")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.fcr900))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Quad")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.quad))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"NRG-500")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.nrg500))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Sanchez")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.sanchez))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"BF-400")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadMoto.moto.bf400))
            imgui.NextColumn()
            imgui.Columns(1)
            imgui.Separator()
        imgui.End()
    end
    if show_other_price.v then 
        imgui.SetNextWindowPos(imgui.ImVec2(420,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((310), 280), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Остальное', show_other_price, imgui.WindowFlags.NoResize)
        local loadOther = inicfg.load(nil, other)
        imgui.Columns(2,'Other', true)
            imgui.Text(u8"Семейные талоны")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.famtalon))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Подарки")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.podarok))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Гражданские талоны")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.grtalon))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Твин-Турбо"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.twinT))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Хеллоуин"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.helloween))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Футуристик"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.futuristic))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Набор "Новый год"')
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.newyear))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Золотая рулетка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.gold))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Серебрянная рулетка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.silver))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Бронзовая рулетка")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.bronze))
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Лавка на ЦР(по центру)")
            imgui.NextColumn()
            imgui.Text(string.format("%s$", loadOther.other.lavka))
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
        local btn_size = imgui.ImVec2(-0.1, 0)
        loadKeys.settings.key1 = encodeJson(ActiveMenu.v)
        inicfg.save(loadKeys, allKeys)
        end
        imgui.Text(u8'\n')
        imgui.Text(u8'Info:')
        imgui.Separator()
        imgui.Text(u8'Script created special for Dream Dynasty\n')
        imgui.Text(string.format("Version:%s ",  thisScript().version))
        imgui.End() 
    end 
    if checkUpdate.v then
        imgui.SetNextWindowPos(imgui.ImVec2(400,460), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2((290), 320), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Меню обновлений', checkUpdate,  imgui.WindowFlags.NoResize)
        imgui.Text(u8'Проверить обновление на:')
        local btn_size = imgui.ImVec2(-0.1, 0)
        update_state = false
    
        if imgui.Button(u8'Скрипт', btn_size) then 
            local update_url = 'https://raw.githubusercontent.com/yummyme/plist/master/versions.ini'
            local update_path = getWorkingDirectory() .. "/resource/versions.ini"
            downloadUrlToFile(update_url, update_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    local updateIni = inicfg.load(nil, update_path)
                    if tonumber(updateIni.NewVers.script) > tonumber(scrV.NewVers.script) then
                        sampAddChatMessage(string.format('Обнаружена новая версия скрипта: {DC143C}[%s]!{FFFFFF} Текущая версия скрипта: {DC143C}[%s].', updateIni.NewVers.script, scrV.NewVers.script ), -1)
                    else
                        sampAddChatMessage("Обновлений нет.", -1)
                    end
                end
            end)
        end
        if imgui.Button(u8'Цены', btn_size) then 
            downloadUrlToFile(update_url, update_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    local updateIni = inicfg.load(nil, update_path)
                    if tonumber(updateIni.version.ini) > tonumber(iniVersion.version.ini) then
                        sampAddChatMessage(string.format('Обнаружен обновленный список цен версии {DC143C}[%s]. {FFFFFF}Текущая версия: {DC143C}[%s]', updateIni.version.ini , iniVersion.version.ini), -1)
                    else
                        sampAddChatMessage("Обновлений нет. ", -1)
                    end
                end
            end)
        end
        imgui.Text(u8'Ссылки на файлы:\n')
        imgui.Separator()
        imgui.Text(u8'Скрипт:')
        imgui.InputText(' ', scriptLink)
        imgui.Text(u8'Цены:')
        imgui.InputText('\n', iniLink)
        imgui.Text(u8'\n')
        imgui.Text(u8'Информация по установке:\n')
        imgui.Separator()
        imgui.Text(u8'[allprices.ini] закинуть с заменой в \n/вашаГТА/moonloader/resource/prices\n')
        imgui.Text(u8'[pricelist_forARZ.lua] закинуть с заменой в \n/вашаГТА/moonloader/')
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
            imgui.End()
    end
    imgui.End()
end

function main()
    if not isSampLoaded() then return end
    while not isSampAvailable() do wait(1) end
    sampAddChatMessage(string.format("{DC143C}[%s]{DC143C} %s Brainburg{FFFFFF} successful loaded.",  thisScript().version, thisScript().name), -1)

    key1 = rkeys.registerHotKey(ActiveMenu.v, true, function ()
        show_main_window.v = not show_main_window.v
        
    end)
    sampAddChatMessage("{DC143C}Активация: {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveMenu.v), "+"), -1)  
	while true do
		wait(0)
        imgui.Process = show_main_window.v
	end
end
