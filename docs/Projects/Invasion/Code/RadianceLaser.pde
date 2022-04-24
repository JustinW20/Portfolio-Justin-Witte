class RadianceLaser {
  float laserXOffset;
  float laserYOffset;
  float laserThickness = 60;

  void updateRadianceLaser() {
    boolean hit = lineRect(theSecondBoss.xPosBoss, theSecondBoss.yPosBoss, theSecondBoss.xPosBoss + laserXOffset, theSecondBoss.yPosBoss + laserYOffset, theMan.xPosMan - theMan.halfPlayerWidth, theMan.yPosMan - theMan.halfPlayerHeight, theMan.halfPlayerWidth * 2, theMan.halfPlayerHeight * 2);
    if (hit) {
      if (!theMan.iFramesActive) {
        theHighScore.score -= 500;
        theMan.currentPlayerHealth -= 1; 
        theMan.iFramesActive = true;
        playerDamage.play();
      }
    }
  }

  void drawRadianceLaser() {
    strokeWeight(laserThickness);
    stroke(118, 66, 138);

    line(theSecondBoss.xPosBoss, theSecondBoss.yPosBoss, theSecondBoss.xPosBoss + laserXOffset, theSecondBoss.yPosBoss + laserYOffset);
    noStroke();
  }

  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return true;
    }
    return false;
  }

  boolean lineRect(float x3, float y3, float x4, float y4, float xR, float yR, float xSize, float ySize) {

    //checking if the line hits any of the players sides
    boolean left = lineLine(x3, y3, x4, y4, xR, yR, xR, yR + ySize);
    boolean right = lineLine(x3, y3, x4, y4, xR + xSize, yR, xR + xSize, yR + ySize);
    boolean top = lineLine(x3, y3, x4, y4, xR, yR, xR + xSize, yR);
    boolean bottom = lineLine(x3, y3, x4, y4, xR, yR + ySize, xR + xSize, yR + ySize);

    if (left || right || top || bottom) {
      return true;
    }
    return false;
  }
}
