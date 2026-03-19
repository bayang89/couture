import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/commande.dart';
import '../providers/commande_provider.dart';
import '../providers/client_provider.dart';

class CommandeFormScreen extends StatefulWidget {
  const CommandeFormScreen({super.key});
  @override State<CommandeFormScreen> createState() => _CommandeFormScreenState();
}

class _CommandeFormScreenState extends State<CommandeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int?   _clientId;
  String _clientNom    = '';
  String _typeVetement = 'Boubou';
  String _tissu        = '';
  String _couleur      = '';
  double _montant      = 0;
  double _acompte      = 0;
  String _mode         = 'Espèces';
  DateTime _dateLiv    = DateTime.now().add(const Duration(days: 10));
  NiveauUrgence _urgence = NiveauUrgence.normale;
  String _instructions = '';
  bool   _saving       = false;

  static const _types  = ['Boubou','Robe','Ensemble 2 pièces','Ensemble 3 pièces',
    'Pantalon','Jupe','Chemise','Costume','Autre'];
  static const _modes  = ['Espèces','Orange Money','Wave','Virement','Carte bancaire'];

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientProvider>().clients;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: () => Navigator.pop(context),
          child: const Text('Annuler', style: TextStyle(color: Colors.white70))),
        leadingWidth: 80,
        title: const Text('Nouvelle commande'),
      ),
      body: Form(key: _formKey,
        child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          _sec('Client'),
          DropdownButtonFormField<int>(
            value: _clientId,
            hint: const Text('Sélectionner un client…'),
            items: clients.map((c) => DropdownMenuItem(
              value: c.id, child: Text(c.nomComplet))).toList(),
            onChanged: (v) {
              setState(() {
                _clientId  = v;
                _clientNom = clients.firstWhere((c) => c.id == v).nomComplet;
              });
            },
            validator: (v) => v == null ? 'Requis' : null,
            decoration: _deco('Client')),
          const SizedBox(height: 14),
          _sec('Vêtement'),
          DropdownButtonFormField<String>(
            value: _typeVetement,
            items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _typeVetement = v!),
            decoration: _deco('Type de vêtement')),
          const SizedBox(height: 10),
          TextFormField(onChanged: (v) => _tissu = v,
            validator: (v) => v!.isEmpty ? 'Requis' : null,
            decoration: _deco('Tissu (ex: Bazin riche, Wax…)')),
          const SizedBox(height: 10),
          TextFormField(onChanged: (v) => _couleur = v,
            decoration: _deco('Couleur / motif')),
          const SizedBox(height: 14),
          _sec('Urgence'),
          Row(children: NiveauUrgence.values.map((u) {
            final sel = _urgence == u;
            Color bg = sel ? (u == NiveauUrgence.tresHaute ? const Color(0xFFE24B4A)
              : u == NiveauUrgence.haute ? const Color(0xFFEF9F27)
              : const Color(0xFF6b2fa0)) : Colors.white;
            return GestureDetector(
              onTap: () => setState(() => _urgence = u),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: sel ? bg : const Color(0x26000000), width: 0.5)),
                child: Text(u.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,
                  color: sel ? Colors.white : const Color(0xFF888780)))));
          }).toList()),
          const SizedBox(height: 14),
          _sec('Finances'),
          Row(children: [
            Expanded(child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => _montant = double.tryParse(v) ?? 0),
              validator: (v) => v!.isEmpty ? 'Requis' : null,
              decoration: _deco('Montant total (FCFA)'))),
            const SizedBox(width: 10),
            Expanded(child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (v) => _acompte = double.tryParse(v) ?? 0,
              decoration: _deco('Acompte (FCFA)'))),
          ]),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _mode,
            items: _modes.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
            onChanged: (v) => setState(() => _mode = v!),
            decoration: _deco('Mode de paiement acompte')),
          const SizedBox(height: 14),
          _sec('Date de livraison'),
          GestureDetector(
            onTap: () async {
              final d = await showDatePicker(context: context,
                initialDate: _dateLiv, firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (_, child) => Theme(data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(primary: Color(0xFF6b2fa0))),
                  child: child!));
              if (d != null) setState(() => _dateLiv = d);
            },
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0x40000000), width: 0.5)),
              child: Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF888780)),
                const SizedBox(width: 8),
                Text('${_dateLiv.day.toString().padLeft(2,'0')}/${_dateLiv.month.toString().padLeft(2,'0')}/${_dateLiv.year}',
                  style: const TextStyle(fontSize: 14)),
              ]))),
          const SizedBox(height: 14),
          _sec('Instructions particulières'),
          TextFormField(maxLines: 3, onChanged: (v) => _instructions = v,
            decoration: _deco('Broderies, finitions, observations…')),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: _saving ? null : _submit,
            child: _saving
              ? const SizedBox(width: 20, height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('Enregistrer la commande'))),
          const SizedBox(height: 30),
        ])));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final c = Commande(
      numero: '', clientId: _clientId!, nomClient: _clientNom,
      statut: StatutCommande.confirmee, urgence: _urgence,
      dateCreation: DateTime.now(), dateLivraisonPrevue: _dateLiv,
      montantTotal: _montant, montantPaye: _acompte,
      observations: _instructions.isEmpty ? null : _instructions,
      articles: [ArticleCommande(modeleId: 0, nomModele: _typeVetement,
        typeVetement: _typeVetement, tissu: _tissu, couleur: _couleur)],
      paiements: _acompte > 0 ? [Paiement(
        montant: _acompte, datePaiement: DateTime.now(), modePaiement: _mode)] : [],
      estEnRetard: false);
    await context.read<CommandeProvider>().creerCommande(c);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Commande créée avec succès !'),
        backgroundColor: Color(0xFF3B6D11)));
      Navigator.pop(context);
    }
  }

  Widget _sec(String t) => Padding(padding: const EdgeInsets.only(bottom: 8),
    child: Text(t.toUpperCase(), style: const TextStyle(
      fontSize: 11, fontWeight: FontWeight.w500,
      color: Color(0xFF888780), letterSpacing: 0.4)));

  InputDecoration _deco(String label) => InputDecoration(
    labelText: label,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14));
}
