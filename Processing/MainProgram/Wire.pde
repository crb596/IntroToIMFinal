//test hi

class Wire 
{
  //members
  String colType; //color of the wire
  color col; //assign color based on colType - can be removed if not used - basically to sync arduino colors
  boolean state; //1 for visible i.e. uncut, 0 for invisible i.e. cut

  Wire(String _colType)
  {
    colType = _colType;
    if (colType == "blue")
      col = color(0, 0, 250);
    else if (colType == "green")
      col = color(0, 250, 0);
    else if (colType == "yellow")
      col = color(250, 250, 0);
    else if (colType == "red")
      col = color(250, 0, 0);
      state = true; //by default, all wores aree uncut
  }
};
