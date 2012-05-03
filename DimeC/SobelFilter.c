void SobelFilter(short Input[9], short Output[1], short Threshold[1]) {
  short p1, p2, p3, p4, p5, p6, p7, p8, p9;
  short Result, Limit;

  // Setup Pixels
  p1 = Input[0];
  p2 = Input[1];
  p3 = Input[2];
  p4 = Input[3];
  p5 = Input[4];
  p6 = Input[5];
  p7 = Input[6];
  p8 = Input[7];
  p9 = Input[8];
  Limit = 4;

  Result = ((((p1 + p3) + (p2 + p2)) - ((p7 + p9) + (p8 + p8))) + (((p7 + p9) + (p8 + p8)) - ((p1 + p3) + (p2 + p2)))) + ((((p3 + p9) + (p6 + p6)) - ((p1 + p7) + (p4 + p4))) + (((p1 + p7) + (p4 + p4)) - ((p3 + p9) + (p6 + p6))));

  if (Result > Limit) {
      Output[0] = 255;
  }
  else {
      Output[0] = 0;
  }

}