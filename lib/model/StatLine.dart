class StatLineOff {
    int yardsPass;
    int yardsRec;
    int yardsRush;
    int recs;  // receptions
    int firstDownRushRec; // first downs rushing or receiving
    int tdPass;
    int tdRec;
    int tdRush;
    int fieldGoals;    
    int xtraPt;
    int twoPt; // two point conversion
}

class StatLineTeamDef {
    int yardsAllow;
    int pointsAllow;
    int sacks;
    int interceptions;
    int fumbleRecovered;
}

class StatLineTeam {
    Map<Player, StatLineOff> statLines;
    StatLineTeamDef statLineDef;
}
