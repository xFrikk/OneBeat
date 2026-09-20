var options:Array<String> = ['story_mode', 'freeplay', 'options', 'concept_art', 'credits'];
var curSelected:Int = 0;
var menuItems:FlxTypedGroup;
var logo:FlxSprite;

function create() {
    var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF243036);
    bg.scrollFactor.set(0, 0);
    add(bg);

    logo = new FlxSprite(100, 200);
    logo.loadGraphic(Paths.image('menu/mod_logo'));
    logo.antialiasing = true;
    add(logo);

    menuItems = new FlxTypedGroup();
    add(menuItems);

    for (i in 0...options.length) {
        var button:FlxSprite = new FlxSprite();
        button.loadGraphic(Paths.image('menu/buttons/' + options[i]));
        button.antialiasing = true;
        button.ID = i;

        switch(options[i]) {
            case 'story_mode': button.x = 850; button.y = 250;
            case 'freeplay':   button.x = 600; button.y = 180;
            case 'options':    button.x = 530; button.y = 320;
            case 'concept_art':button.x = 530; button.y = 440;
            case 'credits':    button.x = 600; button.y = 580;
        }
        menuItems.add(button);
    }
    changeSelection(0);
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) changeSelection(-1);
    if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S) changeSelection(1);

    if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE) {
        FlxG.sound.play(Paths.sound('cancelMenu'));
        FlxG.switchState(new TitleState()); // O adonde quieras que vuelva
    }

    if (FlxG.keys.justPressed.ENTER) selectOption();
}

function changeSelection(change:Int = 0) {
    if (change != 0) FlxG.sound.play(Paths.sound('scrollMenu'));
    curSelected += change;

    if (curSelected < 0) curSelected = options.length - 1;
    if (curSelected >= options.length) curSelected = 0;

    menuItems.forEach(function(spr:FlxSprite) {
        if (spr.ID == curSelected) {
            spr.color = 0xFFFFFF;
            spr.scale.set(1.05, 1.05);
        } else {
            spr.color = 0xFF888888;
            spr.scale.set(1.0, 1.0);
        }
        spr.updateHitbox();
    });
}

function selectOption() {
    FlxG.sound.play(Paths.sound('confirmMenu'));
    var daChoice:String = options[curSelected];

    switch (daChoice) {
        case 'story_mode': FlxG.switchState(new StoryMenuState());
        case 'freeplay':   FlxG.switchState(new FreeplayState());
        case 'options':    FlxG.switchState(new options.MenuOptions()); 
        case 'concept_art': trace("Concept Art seleccionado");
        case 'credits':    FlxG.switchState(new CreditsState());
    }
}