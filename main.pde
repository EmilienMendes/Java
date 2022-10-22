import java.util.HashMap;

void setup() {
  symbole programme, liste_declarations, une_declaration, liste_instructions, instruction, type, affectation, test, condition, operateur;
  symbole t_main, t_acco_f, t_vide, t_id, t_int, t_float, t_egale, t_nombre, t_if, t_else, t_pv, t_inferieur, t_superieur, fin;
  regle r_programme, r_liste_declarations, r_une_declaration, r_liste_instructions, r_instruction, r_type, r_affectation, r_test, r_condition, r_operateur;
  tableauAnalyse tab;
  // Symbole non terminaux
  programme = new symbole("programme", false);
  liste_declarations = new symbole("liste_declaration", false);
  une_declaration = new symbole("une_declaration", false);
  liste_instructions = new symbole("liste_instructions", false);
  instruction = new symbole("instruction", false);
  type = new symbole("type", false);
  affectation = new symbole("affectation", false);
  test = new symbole("test", false);
  condition = new symbole("condition", false);
  operateur = new symbole("operateur", false);

  // Symbole terminaux
  t_main = new symbole("main(){", true);
  t_acco_f = new symbole("}", true);
  t_vide = new symbole("vide", true);
  t_id = new symbole("id", true);
  t_int = new symbole("int", true);
  t_float = new symbole("float", true);
  t_egale = new symbole("=", true);
  t_nombre = new symbole("nombre", true);
  t_if = new symbole("if", true);
  t_else = new symbole("else", true);
  t_pv = new symbole(";", true);
  t_inferieur = new symbole("<", true);
  t_superieur = new symbole(">", true);
  fin = new symbole("$", true);

  // Regle 1
  r_programme = new regle(programme);
  r_programme.creer_Regle();
  r_programme.ajouterSymbole(t_main);
  r_programme.ajouterSymbole(liste_declarations);
  r_programme.ajouterSymbole(liste_instructions);
  r_programme.ajouterSymbole(t_acco_f);

  // Regle 2
  r_liste_declarations = new regle(liste_declarations);
  r_liste_declarations.creer_Regle();
  r_liste_declarations.ajouterSymbole(une_declaration);
  r_liste_declarations.ajouterSymbole(liste_declarations);
  r_liste_declarations.creer_Regle();
  r_liste_declarations.ajouterSymbole(t_vide);

  // Regle 3
  r_une_declaration = new regle(une_declaration);
  r_une_declaration.creer_Regle();
  r_une_declaration.ajouterSymbole(type);
  r_une_declaration.ajouterSymbole(t_id);

  // Regle 4
  r_liste_instructions = new regle(liste_instructions);
  r_liste_instructions.creer_Regle();
  r_liste_instructions.ajouterSymbole(instruction);
  r_liste_instructions.ajouterSymbole(liste_instructions);
  r_liste_instructions.creer_Regle();
  r_liste_instructions.ajouterSymbole(t_vide);

  // Regle 5
  r_instruction = new regle(instruction);
  r_instruction.creer_Regle();
  r_instruction.ajouterSymbole(affectation);
  r_instruction.creer_Regle();
  r_instruction.ajouterSymbole(test);

  // Regle 6
  r_type = new regle(type);
  r_type.creer_Regle();
  r_type.ajouterSymbole(t_int);
  r_type.creer_Regle();
  r_type.ajouterSymbole(t_float);

  // Regle 7
  r_affectation = new regle(affectation);
  r_affectation.creer_Regle();
  r_affectation.ajouterSymbole(t_id);
  r_affectation.ajouterSymbole(t_egale);
  r_affectation.ajouterSymbole(t_nombre);
  r_affectation.ajouterSymbole(t_pv);

  // Regle 8
  r_test = new regle(test);
  r_test.creer_Regle();
  r_test.ajouterSymbole(t_if);
  r_test.ajouterSymbole(condition);
  r_test.ajouterSymbole(instruction);
  r_test.ajouterSymbole(t_else);
  r_test.ajouterSymbole(instruction);
  r_test.ajouterSymbole(t_pv);

  // Regle 9
  r_condition = new regle(condition);
  r_condition.creer_Regle();
  r_condition.ajouterSymbole(t_id);
  r_condition.ajouterSymbole(operateur);
  r_condition.ajouterSymbole(t_nombre);

  // Regle 10
  r_operateur = new regle(operateur);
  r_operateur.creer_Regle();
  r_operateur.ajouterSymbole(t_inferieur);
  r_operateur.creer_Regle();
  r_operateur.ajouterSymbole(t_superieur);
  r_operateur.creer_Regle();
  r_operateur.ajouterSymbole(t_egale);

  ArrayList<regle> tableauDeRegle = new ArrayList<regle>(10);

  tableauDeRegle.add(r_programme);
  tableauDeRegle.add(r_liste_declarations);
  tableauDeRegle.add(r_une_declaration);
  tableauDeRegle.add(r_liste_instructions);
  tableauDeRegle.add(r_instruction);
  tableauDeRegle.add(r_type);
  tableauDeRegle.add(r_affectation);
  tableauDeRegle.add(r_test);
  tableauDeRegle.add(r_condition);
  tableauDeRegle.add(r_operateur);

  /* Affichage des regles
   r_programme.afficherRegle();
   r_liste_declarations.afficherRegle();
   r_une_declaration.afficherRegle();
   r_liste_instructions.afficherRegle();
   r_instruction.afficherRegle();
   r_type.afficherRegle();
   r_affectation.afficherRegle();
   r_test.afficherRegle();
   r_condition.afficherRegle();
   r_operateur.afficherRegle();
   */
  // Pas oublier plusieurs arraylist par regle !!!!!!!!!!!!!!!!!
  // Creation tableau analyse

  tab = new tableauAnalyse();
  //RO PROGRAMME
  tab.ajouterRegle(programme);
  tab.ajouter_tab_symb_term(programme);
  tab.ajouter_symb_term(t_main, 0, programme);
  //R1 ET R1' LISTE DECLARATION
  tab.ajouterRegle (liste_declarations);
  tab.ajouter_tab_symb_term(liste_declarations);
  tab.ajouter_tab_symb_term(liste_declarations);
  tab.ajouter_symb_term(t_int, 0, liste_declarations);
  tab.ajouter_symb_term(t_float, 0, liste_declarations);

  tab.ajouter_symb_term(t_if, 1, liste_declarations);
  tab.ajouter_symb_term(t_acco_f, 1, liste_declarations);
  tab.ajouter_symb_term(t_id, 1, liste_declarations);
  tab.ajouter_symb_term(t_vide, 1, liste_declarations);
  //R2 UNE DECLARATION
  tab.ajouterRegle(une_declaration);
  tab.ajouter_tab_symb_term(une_declaration);
  tab.ajouter_symb_term(t_int, 0, une_declaration);
  tab.ajouter_symb_term(t_float, 0, une_declaration);
  //R3 ET R3' LISTE INSTRUCTION
  tab.ajouterRegle(liste_instructions);
  tab.ajouter_tab_symb_term(liste_instructions);
  tab.ajouter_tab_symb_term(liste_instructions);
  tab.ajouter_symb_term(t_id, 0, liste_instructions);
  tab.ajouter_symb_term(t_if, 0, liste_instructions);

  tab.ajouter_symb_term(t_acco_f, 1, liste_instructions);
  tab.ajouter_symb_term(t_vide, 1, liste_instructions);

  //R4 ET R4'
  tab.ajouterRegle(instruction);
  tab.ajouter_tab_symb_term(instruction);
  tab.ajouter_tab_symb_term(instruction);
  tab.ajouter_symb_term(t_id, 0, instruction);

  tab.ajouter_symb_term(t_if, 1, instruction);

  //R5 ET R5'
  tab.ajouterRegle(type);
  tab.ajouter_tab_symb_term(type);
  tab.ajouter_tab_symb_term(type);
  tab.ajouter_symb_term(t_int, 0, type);

  tab.ajouter_symb_term(t_float, 1, type);

  //R6
  tab.ajouterRegle(affectation);
  tab.ajouter_tab_symb_term(affectation);
  tab.ajouter_symb_term(t_id, 0, affectation);

  //R7
  tab.ajouterRegle(test);
  tab.ajouter_tab_symb_term(test);
  tab.ajouter_symb_term(t_if, 0, test);

  //R8
  tab.ajouterRegle(condition);
  tab.ajouter_tab_symb_term(condition);
  tab.ajouter_symb_term(t_id, 0, condition);

  //R9
  tab.ajouterRegle(operateur);
  tab.ajouter_tab_symb_term(operateur);
  tab.ajouter_tab_symb_term(operateur);
  tab.ajouter_tab_symb_term(operateur);
  tab.ajouter_symb_term(t_inferieur, 0, operateur);

  tab.ajouter_symb_term(t_superieur, 1, operateur);

  tab.ajouter_symb_term(t_egale, 2, operateur);

  //affichage du tableau d'analyse
  tab.afficherHash();

  // Entree
  symbole[] chaine = new symbole[23];
  chaine[0]=t_main;
  chaine[1]=t_int;
  chaine[2]=t_id;
  chaine[3]=t_id;
  chaine[4]=t_egale;
  chaine[5]=t_nombre;
  chaine[6]=t_pv;
  chaine[7]=t_if;
  chaine[8]=t_id;
  chaine[9]=t_inferieur;
  chaine[10]=t_nombre;
  chaine[11]=t_id;
  chaine[12]=t_egale;
  chaine[13]=t_nombre;
  chaine[14]=t_pv;
  chaine[15]=t_else;
  chaine[16]=t_id;
  chaine[17]=t_egale;
  chaine[18]=t_nombre;
  chaine[19]=t_pv;
  chaine[20]=t_pv;
  chaine[21]=t_acco_f;
  chaine[22]=fin;
  
  
  
  ArrayList <symbole> chaineRentrer = new ArrayList <symbole>();
  String[] lines = loadStrings("file_test.txt");
  for (int i = 0; i < lines.length; i++) {
    String [] word= split(lines[i], " ");
    for (int j = 0; j<word.length; j++) {
      if (word[j].equals("main(){")) {
        chaineRentrer.add(t_main);
        //println("1");
      } else if (word[j].equals("}")) {
        chaineRentrer.add(t_acco_f);
        //println("2");
      } else if (word[j].equals( "id")) {
        chaineRentrer.add(t_id);
        //println("3");
      } else if (word[j].equals( "int")) {
        chaineRentrer.add(t_int);
        //println("4");
      } else if (word[j].equals( "float")) {
        chaineRentrer.add(t_float);
        //println("5");
      } else if (word[j].equals( "=")) {
        chaineRentrer.add(t_egale);
        //println("6");
      } else if (word[j].equals( "nombre")) {
        chaineRentrer.add(t_nombre);
        //println("7");
      } else if (word[j].equals( ";")) {
        chaineRentrer.add(t_pv);
        //println("8");
      } else if (word[j].equals( "if")) {
        chaineRentrer.add(t_if);
        //println("9");
      } else if (word[j].equals( "else")) {
        chaineRentrer.add(t_else);
        //println("10");
      } else if (word[j].equals( "<")) {
        chaineRentrer.add(t_inferieur);
        //println("11");
      } else if (word[j].equals( ">")) {
        chaineRentrer.add(t_superieur);
        //println("12");
      }
      else if (word[j].equals( " ")) {
        //println("13");
        continue;
        
      }else if (word[j].equals( "vide")) {
        chaineRentrer.add(t_vide);
        //println("-1");
      } else {
        //println("Erreur de syntaxe du symbole terminale");
        exit();
      }
    }
     chaineRentrer.add(fin);
  }
  println("");
  
  for (int k = 0; k<chaineRentrer.size(); k++) {
    print(chaineRentrer.get(k).nom + " ");
  }


  // Pile
  Stack<symbole> pile = new Stack<symbole>();
  pile.push(fin);
  pile.push(programme);

  algorithme(tab,chaineRentrer,pile,tableauDeRegle);
}  
