PrintWriter etape_output, regle_output;


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
    if (!X.isTerminal()) { // Si X non terminal, on verifie que dans les NT correspondant a X il y a a
      int co = correspondance(X, a, tab);

      if (co != -1) {
        pile.pop();

        for (int i =0; i<tabRegle.size(); i++) {
          if (tabRegle.get(i).symb.equals(X)) {
            tabRegle.get(i).afficherRegle(regle_output);
            try {
              for (int j = tabRegle.get(i).regle.get(co).size(); j>0; j--) {
                pile.push(tabRegle.get(i).regle.get(co).get(j-1));
              }
            }
            catch (Exception e) {
              println("Etape " + etape);
              e.printStackTrace();
            }
          }
        }
      } else {
        fin_fichier("erreur de syntaxe1", etape_output, regle_output);
        //println("erreur de syntaxe1");
        return false;
      }
    } else if (X.isTerminal() || X.nom == "$") {
      if (X.nom == "$") {
        if (a.nom == "$") {
          fin_fichier("chaine acceptee", etape_output, regle_output);
          //println("chaine acceptee");
          return true;
        } else {
          //println("erreur de syntaxe2");
          fin_fichier("erreur de syntaxe2", etape_output, regle_output);
          return false;
        }
      } else if (X.nom == a.nom) {
        pile.pop();
        indice_chaine++;
      } else {
        //println("erreur de syntaxe3");
        fin_fichier("erreur de syntaxe3", etape_output, regle_output);
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

        indice = j;
      }
    }
  }
  //println(indice);
  return indice;
}


void fin_fichier(String msg, PrintWriter file1, PrintWriter file2) {
  println(msg);
  file1.println(msg);
  file1.flush();
  file1.close();
  file2.println(msg);
  file2.flush();
  file2.close();
  exit();
}


/*Algo Analyse_Syntaxique_predictive()
 {
 repeter
 {
 . soit X le symbole de sommet de pile
 . soit a appartenant à VT le symbole courant de la chaine à
 analyser
 si X appartient à VN alors // symbole non terminal
 {
 si TA[X,a]={X::=y1y2y3...yn} alors
 {
 . dépiler X
 . empiler yn puis yn-1 puis...y1
 . « émettre en sortie » la règle X::= y1y2y3...yn
 }
 sinon « émettre une erreur de syntaxe »
 }
 sinon // X est un symbole terminal ou $
 {
 si X==$ alors
 {
 si a=$ alors « émettre chaine acceptée»
 sinon « émettre erreur de syntaxe »
 }
 sinon // X est un symbole terminal
 {
 si X=a alors
 {
 . dépiler X
 . passer au symbole suivant de la chaine à analyser
 }
 sinon émettre « erreur de syntaxe »
 }
 } jusqu'à « erreur de syntaxe » ou « chaine acceptée »
 }
 */
