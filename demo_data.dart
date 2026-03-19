// ============================================================
// DONNÉES DE DÉMO — utilisées quand kDemoMode = true
// ============================================================

import '../models/commande.dart';
import '../models/client.dart';

class DemoData {

  // ── CLIENTS ─────────────────────────────────────────────
  static final List<Client> clients = [
    Client(id: 1, nom: 'Diallo',   prenom: 'Aissatou',   telephone: '+221 77 432 10 87',
      whatsapp: '+221 77 432 10 87', quartier: 'Médina, Dakar',
      stylePrefere: 'Traditionnel', finitions: 'Broderies dorées, doublure systématique',
      actif: true),
    Client(id: 2, nom: 'Ba',       prenom: 'Mariama',     telephone: '+221 76 234 56 78',
      whatsapp: '+221 76 234 56 78', quartier: 'Plateau, Dakar',
      stylePrefere: 'Moderne', finitions: 'Col claudine, fermeture invisible',
      actif: true),
    Client(id: 3, nom: 'Camara',   prenom: 'Kadiatou',    telephone: '+221 78 901 23 45',
      whatsapp: '+221 78 901 23 45', quartier: 'Almadies, Dakar',
      stylePrefere: 'Élégant soirée', finitions: 'Paillettes, décolleté dos',
      actif: true),
    Client(id: 4, nom: 'Traoré',   prenom: 'Fatoumata',   telephone: '+221 77 555 88 99',
      whatsapp: '', quartier: 'Parcelles, Dakar',
      stylePrefere: 'Mixte', finitions: 'Simple, pratique',
      actif: true),
    Client(id: 5, nom: 'Kouyaté',  prenom: 'Nafissatou',  telephone: '+221 76 112 34 56',
      whatsapp: '+221 76 112 34 56', quartier: 'Grand Dakar',
      stylePrefere: 'Traditionnel moderne', finitions: 'Dentelle, broderie fine',
      actif: true),
    Client(id: 6, nom: 'Sow',      prenom: 'Ibrahima',    telephone: '+221 78 667 44 20',
      whatsapp: '+221 78 667 44 20', quartier: 'Point E, Dakar',
      stylePrefere: 'Formel', finitions: 'Costume 3 pièces, cravate assortie',
      actif: true),
    Client(id: 7, nom: 'Touré',    prenom: 'Aminata',     telephone: '+221 77 321 98 65',
      whatsapp: '+221 77 321 98 65', quartier: 'Fann, Dakar',
      stylePrefere: 'Chic décontracté', finitions: 'Lin, coton naturel',
      actif: true),
    Client(id: 8, nom: 'Ndiaye',   prenom: 'Oumar',       telephone: '+221 76 456 78 90',
      whatsapp: '', quartier: 'Pikine',
      stylePrefere: 'Traditionnel', finitions: 'Boubou large, tissu bazin',
      actif: true),
  ];

  // ── COMMANDES ────────────────────────────────────────────
  static final List<Commande> commandes = [
    Commande(
      id: 47, numero: 'CMD-00047',
      clientId: 1, nomClient: 'Aissatou Diallo',
      statut: StatutCommande.enRetard, urgence: NiveauUrgence.haute,
      dateCreation: DateTime(2026, 3, 1),
      dateLivraisonPrevue: DateTime(2026, 3, 17),
      montantTotal: 45000, montantPaye: 25000,
      observations: 'Broderies dorées sur le col et les manches. Doublure soie blanche.',
      articles: [ArticleCommande(id: 1, modeleId: 1, nomModele: 'Boubou Kaftan',
        typeVetement: 'Boubou 3 pièces', tissu: 'Bazin riche', couleur: 'Bleu royal & or',
        doublure: 'Soie blanche', instructionsSpeciales: 'Broderies dorées col et manches')],
      paiements: [Paiement(id: 1, montant: 25000,
        datePaiement: DateTime(2026, 3, 1), modePaiement: 'Orange Money')],
      estEnRetard: true,
    ),
    Commande(
      id: 49, numero: 'CMD-00049',
      clientId: 2, nomClient: 'Mariama Ba',
      statut: StatutCommande.enEssayage, urgence: NiveauUrgence.normale,
      dateCreation: DateTime(2026, 3, 5),
      dateLivraisonPrevue: DateTime(2026, 3, 22),
      dateEssayage: DateTime(2026, 3, 20),
      montantTotal: 32000, montantPaye: 32000,
      observations: 'Essayage prévu le 20 mars à 10h00.',
      articles: [ArticleCommande(id: 2, modeleId: 2, nomModele: 'Ensemble moderne',
        typeVetement: 'Ensemble 2 pièces', tissu: 'Wax imprimé', couleur: 'Vert & blanc',
        instructionsSpeciales: 'Col claudine, fermeture invisible dos')],
      paiements: [
        Paiement(id: 2, montant: 20000, datePaiement: DateTime(2026, 3, 5), modePaiement: 'Espèces'),
        Paiement(id: 3, montant: 12000, datePaiement: DateTime(2026, 3, 15), modePaiement: 'Wave'),
      ],
      estEnRetard: false,
    ),
    Commande(
      id: 51, numero: 'CMD-00051',
      clientId: 3, nomClient: 'Kadiatou Camara',
      statut: StatutCommande.terminee, urgence: NiveauUrgence.normale,
      dateCreation: DateTime(2026, 3, 3),
      dateLivraisonPrevue: DateTime(2026, 3, 19),
      montantTotal: 28000, montantPaye: 28000,
      observations: 'Commande terminée, prête à livrer.',
      articles: [ArticleCommande(id: 3, modeleId: 3, nomModele: 'Robe soirée',
        typeVetement: 'Robe de soirée', tissu: 'Satin', couleur: 'Rouge bordeaux',
        instructionsSpeciales: 'Paillettes sur le bustier, décolleté dos')],
      paiements: [Paiement(id: 4, montant: 28000,
        datePaiement: DateTime(2026, 3, 3), modePaiement: 'Virement')],
      estEnRetard: false,
    ),
    Commande(
      id: 52, numero: 'CMD-00052',
      clientId: 4, nomClient: 'Fatoumata Traoré',
      statut: StatutCommande.enCouture, urgence: NiveauUrgence.normale,
      dateCreation: DateTime(2026, 3, 8),
      dateLivraisonPrevue: DateTime(2026, 3, 25),
      montantTotal: 18000, montantPaye: 10000,
      articles: [ArticleCommande(id: 4, modeleId: 4, nomModele: 'Jupe + haut',
        typeVetement: 'Ensemble jupe + haut', tissu: 'Coton imprimé', couleur: 'Orange & noir')],
      paiements: [Paiement(id: 5, montant: 10000,
        datePaiement: DateTime(2026, 3, 8), modePaiement: 'Orange Money')],
      estEnRetard: false,
    ),
    Commande(
      id: 53, numero: 'CMD-00053',
      clientId: 6, nomClient: 'Ibrahima Sow',
      statut: StatutCommande.confirmee, urgence: NiveauUrgence.normale,
      dateCreation: DateTime(2026, 3, 10),
      dateLivraisonPrevue: DateTime(2026, 3, 30),
      dateEssayage: DateTime(2026, 3, 20),
      montantTotal: 55000, montantPaye: 30000,
      observations: 'Costume 3 pièces avec cravate assortie.',
      articles: [ArticleCommande(id: 5, modeleId: 5, nomModele: 'Costume 3 pièces',
        typeVetement: 'Costume', tissu: 'Laine légère', couleur: 'Gris anthracite',
        instructionsSpeciales: 'Cravate assortie, pochette bleue')],
      paiements: [Paiement(id: 6, montant: 30000,
        datePaiement: DateTime(2026, 3, 10), modePaiement: 'Virement')],
      estEnRetard: false,
    ),
    Commande(
      id: 48, numero: 'CMD-00048',
      clientId: 5, nomClient: 'Nafissatou Kouyaté',
      statut: StatutCommande.terminee, urgence: NiveauUrgence.normale,
      dateCreation: DateTime(2026, 3, 2),
      dateLivraisonPrevue: DateTime(2026, 3, 19),
      montantTotal: 24000, montantPaye: 12000,
      articles: [ArticleCommande(id: 6, modeleId: 2, nomModele: 'Ensemble dentelle',
        typeVetement: 'Ensemble 3 pièces', tissu: 'Dentelle + coton', couleur: 'Crème & or')],
      paiements: [Paiement(id: 7, montant: 12000,
        datePaiement: DateTime(2026, 3, 2), modePaiement: 'Espèces')],
      estEnRetard: false,
    ),
  ];

  // ── DASHBOARD KPIs ────────────────────────────────────────
  static Map<String, dynamic> get dashboard => {
    'total_clients_actifs':    clients.where((c) => c.actif).length,
    'commandes_actives':       commandes.where((c) =>
      [StatutCommande.confirmee, StatutCommande.enCoupe,
       StatutCommande.enCouture, StatutCommande.enEssayage,
       StatutCommande.enRetouche, StatutCommande.enRetard]
      .contains(c.statut)).length,
    'commandes_en_retard':     commandes.where((c) => c.estEnRetard).length,
    'livraisons_aujourd_hui':  2,
    'ca_mois':                 485000.0,
    'total_impaye':            87000.0,
    'commandes_par_statut': {
      'brouillon': 0, 'confirmee': 1, 'en_coupe': 0,
      'en_couture': 1, 'en_essayage': 1, 'en_retouche': 0,
      'terminee': 2, 'livree': 8, 'annulee': 0, 'en_retard': 1,
    },
  };
}
