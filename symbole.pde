class symbole{
  public String nom;
  public boolean terminal;
  symbole(String n,boolean t){
    nom = n;
    // Symbole non terminal true
    // Symbole non terminal :  false
    terminal = t; 
  }
  
  public boolean isTerminal(){
  return terminal;
  }
  
  
}
