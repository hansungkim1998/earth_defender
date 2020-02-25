class GameState {
    Stage stage;

    /**
     * Initialize game state to INTRO
     */
    GameState() {
        stage = Stage.INTRO;
    }

    /**
     * Getter method for stage
     *
     * @return current stage of the game
     */
    Stage getStage() {
        return stage;
    }
}
