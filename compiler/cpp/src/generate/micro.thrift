
struct YYYY {
  1: required i16  year;
}

service TixStore {
    string yearToString( 1:YYYY yr );
}
