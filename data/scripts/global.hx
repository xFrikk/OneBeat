import sys.FileSystem;

function onStateSwitch(e) {
    // Si el juego intenta abrir el MainMenuState original...
    if (Type.getClassName(Type.getClass(e.state)) == "MainMenuState") {
        // Bloqueamos que abra el original
        e.cancel();
        // Lo obligamos a abrir un CustomState que lea nuestro archivo
        FlxG.switchState(new CustomState("MainMenuState"));
    }
}