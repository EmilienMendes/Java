class regle{
  public symbole symb;
  ArrayList <ArrayList<symbole>> regle;
  int indice_regle;
  regle(symbole s){
    symb = s;  
    regle = new ArrayList <ArrayList<symbole>>();
    indice_regle = -1;
  }
  
  // Ajoute une nouvelle regle
  public void creer_Regle(){
    regle.add(new ArrayList<symbole> ());
    indice_regle ++;
  }
  
  public void ajouterSymbole(symbole s){
    regle.get(indice_regle).add(s); // Ajoute un symbole a la regle i
  }
  
  public void afficherRegle(PrintWriter file){
    //print("<" + symb.nom + "> ::= "); 
    file.print("<" + symb.nom + "> ::= ");
    for (int i =0;i<regle.size();i++){
      if (i > 0){
        file.print(" | ");
        //print (" | ");
      }
      for (int j = 0;j<regle.get(i).size();j++){
        if(!regle.get(i).get(j).isTerminal()){
          file.print("<");
          //print("<");
        }
        file.print(regle.get(i).get(j).nom );
        //print(regle.get(i).get(j).nom );
        if(!regle.get(i).get(j).isTerminal()){
          file.print(">");
          //print(">");
        }
       
     
      }
    }
    file.println("");
    println("");
  }
  public symbole getSymbole(){
    return symb;
  }
}
