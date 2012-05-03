/*DC_INDEX 1*/void SobelFilter(short Input[9], short Output[1], short Threshold[1]) {
/*DC_INDEX 2*/short p1, p2, p3, p4, p5, p6, p7, p8, p9;
/*DC_INDEX 3*/short Result, Limit;
/*DC_INDEX 4*/
/*DC_INDEX 5*/
/*DC_INDEX 6*/p1 = Input[0];
/*DC_INDEX 7*/p2 = Input[1];
/*DC_INDEX 8*/p3 = Input[2];
/*DC_INDEX 9*/p4 = Input[3];
/*DC_INDEX 10*/p5 = Input[4];
/*DC_INDEX 11*/p6 = Input[5];
/*DC_INDEX 12*/p7 = Input[6];
/*DC_INDEX 13*/p8 = Input[7];
/*DC_INDEX 14*/p9 = Input[8];
/*DC_INDEX 15*/Limit = 4;
/*DC_INDEX 16*/
/*DC_INDEX 17*/Result = ((((p1 + p3) + (p2 + p2)) - ((p7 + p9) + (p8 + p8))) + (((p7 + p9) + (p8 + p8)) - ((p1 + p3) + (p2 + p2)))) + ((((p3 + p9) + (p6 + p6)) - ((p1 + p7) + (p4 + p4))) + (((p1 + p7) + (p4 + p4)) - ((p3 + p9) + (p6 + p6))));
/*DC_INDEX 18*/
/*DC_INDEX 19*/if (Result > Limit) {
/*DC_INDEX 20*/Output[0] = 255;
/*DC_INDEX 21*/}
/*DC_INDEX 22*/else {
/*DC_INDEX 23*/Output[0] = 0;
/*DC_INDEX 24*/}
/*DC_INDEX 25*/
/*DC_INDEX 26*/}
