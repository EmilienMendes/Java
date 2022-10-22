PrintWriter etape_output,regle_output;


boolean algorithme(tableauAnalyse tab, ArrayList<symbole> chaine, Stack<symbole> pile, ArrayList<regle> tabRegle) {
  int indice_chaine = 0;
  int etape = 0;
  etape_output = createWriter("etape.txt");
  regle_output = createWriter("regle.txt");
  
  while (true) {
    symbole X = pile.peek();
    symbole a = chaine.get(indice_chaine);
    etape_output.println("Etape " + etape + " \t X : " + X.nom + " \t a : " + a.nom);
    etape++;
    
    println("##########" + etape + " Symbole courant " + a.nom);
    for(int i = 0; i<pile.size();i++)
      print(pile.get(i).nom + " ");
    println();
    println("###########");
    
    if (!X.isTerminal()) { // Si X non terminal, on verifie que dans les NT correspondant a X il y a a
      int co = correspondance(X, a, tab);
      
      if (co != -1) {
        pile.pop();
        println("Co =" + co);

        for (int i =0; i<tabRegle.size(); i++) {
          if (tabRegle.get(i).symb.equals(X)) {
            tabRegle.get(i).afficherRegle(regle_output);
            
            for (int j = tabRegle.get(i).regle.get(co).size(); j>0; j--) {
              //println(tabRegle.get(i).regle.get(co).get(j-1).nom);
              if(tabRegle.get(i).regle.get(co).get(j-1).nom == "vide")
                break;
              pile.push(tabRegle.get(i).regle.get(co).get(j-1));
            }
          }
        }
      } else {
        fin_fichier("erreur de syntaxe1",etape_output,regle_output);
        //println("erreur de syntaxe1");
        return false;
      }
    } else if (X.isTerminal() || X.nom == "$" ) {
      if (X.nom == "$") {
        if (a.nom == "$") {
          fin_fichier("chaine acceptee",etape_output,regle_output);
          //println("chaine acceptee");
          return true;
        } else {
          //println("erreur de syntaxe2");
          fin_fichier("erreur de syntaxe2",etape_output,regle_output);
          return false;
        }
      } else if (X.nom == a.nom) {
        pile.pop();
        indice_chaine++;
      } else {
        //println("erreur de syntaxe3");
        fin_fichier("erreur de syntaxe3",etape_output,regle_output);
        return false;
      }
    }
  }
}

int correspondance(symbole X, symbole a, tableauAnalyse tableau) {
  int indice = -1;
  for (int i =0; i<tableau.tabAnalyse.get(X).size(); i++) {
    for (int j=0; j<tableau.tabAnalyse.get(X).get(i).size(); j++) {
      if (a.equals(tableau.tabAnalyse.get(X).get(i).get(j))) {
        //print("test " +a.nom + " = " + X.nom);
        indice=i;
        //println(" " + indice);
      }
    }
  }
  //println(indice);
  return indice;
}


void fin_fichier(String msg,PrintWriter file1,PrintWriter file2){
  println(msg);
  file1.println(msg);
  file1.flush();
  file1.close();
  file2.println(msg);
  file2.flush();
  file2.close();
  exit();
} 
