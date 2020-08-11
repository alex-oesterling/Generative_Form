String[] lines;
int total = 0;

void scannerSetup(){
  lines = loadStrings("phrases.txt");
  total = lines.length;
}

String getPhrase(){
  return lines[(int)random(0, total)];
}
