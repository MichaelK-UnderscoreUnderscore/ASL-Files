state ("NyxQuest")
{
    string19 LevelName : "NyxQuest.exe", 0x002CF0E0, 0x18, 0x18, 0x0, 0x18, 0x0, 0xB4, 0x10;
    bool Loading : "NyxQuest.exe", 0x002CF0E0, 0x18, 0x18, 0x0, 0x54, 0xFC, 0x24, 0x69A;
    float posX : "NyxQuest.exe", 0x002CF0E0, 0x20, 0x4, 0x1c, 0x0, 0xc, 0x0, 0x40;
    float posZ : "NyxQuest.exe", 0x002CF0E0, 0x20, 0x4, 0x1c, 0x0, 0xc, 0x0, 0x44;
}

post_Game = false;

startup
{
    settings.Add("Splits", true);
    settings.Add("level_1",  true, "Ruins of Corinth", "Splits");         // "Levels/E1/L1.txt"
    settings.Add("level_2",  true, "Valley of the Temples", "Splits");    // "Levels/E1/L2.txt"
    settings.Add("level_3",  true, "The Dry Swamp", "Splits");            // "Levels/E1/L3.txt"
    settings.Add("level_4",  true, "Olympia", "Splits");                  // "Levels/E1/L4.txt"
    settings.Add("level_5",  true, "Aeolia", "Splits");                   // "Levels/E1/L5.txt"
    settings.Add("level_6",  true, "Temple of Aeolia", "Splits");         // "Levels/E1/L6.txt"
    settings.Add("level_7",  true, "Thessaly", "Splits");                 // "Levels/E1/L7.txt"
    settings.Add("level_8",  true, "The Forgotten Passages", "Splits");   // "Levels/E1/L8.txt"
    settings.Add("level_9",  true, "Fields of Argos", "Splits");          // "Levels/E1/L9.txt"
    settings.Add("level_10", true, "Oracle of Delphi", "Splits");         // "Levels/E1/L10.txt"
    settings.Add("level_11", true, "Mount Parnassus", "Splits");          // "Levels/E1/L11.txt"
    settings.Add("level_12", true, "Mount Parnassus ||", "Splits");       // "Levels/E1/L12.txt"
    //settings.Add("level_13", true, "Arcadia", "Splits");                  // "Levels/E1/L13.txt"
    settings.Add("Settings", true);
    settings.Add("100_no_reset", false, "No Reset after Mount Parnassus ||", "Settings");
    //settings.Add("arcadia_il", false, "Arcadia IL", "Settings");

    vars.TimerModel = new TimerModel { CurrentState = timer };
}

start
{
    post_Game = false;
    if (current.LevelName != old.LevelName)
    {
        return new List<string>()
        {
            "Levels/E1/L1.txt",
            "Levels/E1/L2.txt",
            "Levels/E1/L3.txt",
            "Levels/E1/L4.txt",
            "Levels/E1/L5.txt",
            "Levels/E1/L6.txt",
            "Levels/E1/L7.txt",
            "Levels/E1/L8.txt",
            "Levels/E1/L9.txt",
            "Levels/E1/L10.txt",
            "Levels/E1/L11.txt",
            "Levels/E1/L12.txt",
            "Levels/E1/L13.txt"
        }.Contains(current.LevelName);
    }
}

onStart
{
    timer.IsGameTimePaused = true;
}

split
{
    float end = 813.6279f;
    if (current.LevelName == "Levels/E1/L12.txt" && settings["level_12"] && current.posX >= end && old.posX < end)
    {   //Didn't find a better way then just splitting on position for the final level, don't jump over lol
        post_Game = true;
        return true;
    }

    return current.LevelName != old.LevelName
        && (
               (current.LevelName == "Levels/E1/L2.txt"  && settings["level_1"])
            || (current.LevelName == "Levels/E1/L3.txt"  && settings["level_2"])
            || (current.LevelName == "Levels/E1/L4.txt"  && settings["level_3"])
            || (current.LevelName == "Levels/E1/L5.txt"  && settings["level_4"])
            || (current.LevelName == "Levels/E1/L6.txt"  && settings["level_5"])
            || (current.LevelName == "Levels/E1/L7.txt"  && settings["level_6"])
            || (current.LevelName == "Levels/E1/L8.txt"  && settings["level_7"])
            || (current.LevelName == "Levels/E1/L9.txt"  && settings["level_8"])
            || (current.LevelName == "Levels/E1/L10.txt" && settings["level_9"])
            || (current.LevelName == "Levels/E1/L11.txt" && settings["level_10"])
            || (current.LevelName == "Levels/E1/L12.txt" && settings["level_11"])
        );
}


isLoading
{
    return current.Loading;
}

reset
{
    return !(settings["100_no_reset"] && !post_Game) && !settings["arcadia_il"] && current.LevelName == "Levels/MainMenu.txt";
}

