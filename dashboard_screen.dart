import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/commande_provider.dart';
import '../providers/auth_provider.dart';
import '../models/commande.dart';
import '../data/demo_data.dart';
import '../widgets/commande_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommandeProvider, AuthProvider>(
      builder: (ctx, cmd, auth, _) {
        final kpis  = DemoData.dashboard;
        final today = DateTime.now();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tableau de bord'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  auth.logout();
                  Navigator.pushReplacementNamed(ctx, '/login');
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            color: const Color(0xFF6b2fa0),
            onRefresh: cmd.chargerCommandes,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // ── Salutation ────────────────────────
                Text('Bonjour, ${auth.nomUtilisateur} 👋',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                Text(
                  '${_jourSemaine(today)} ${today.day} ${_mois(today.month)} ${today.year}  •  ${kpis['commandes_actives']} commandes actives',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF888780))),
                const SizedBox(height: 20),
                // ── KPIs ──────────────────────────────
                GridView.count(crossAxisCount: 2, shrinkWrap: true,
                  crossAxisSpacing: 10, mainAxisSpacing: 10,
                  childAspectRatio: 1.8,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _kpi('Commandes actives', '${kpis['commandes_actives']}',
                      '${kpis['commandes_en_retard']} en retard', dark: true),
                    _kpi('Livraisons aujourd\'hui',
                      '${kpis['livraisons_aujourd_hui']}', 'à remettre'),
                    _kpi('CA du mois',
                      _fcfa(kpis['ca_mois']), 'FCFA encaissés'),
                    _kpi('Impayés',
                      _fcfa(kpis['total_impaye']), 'soldes en attente', alert: true),
                  ]),
                const SizedBox(height: 22),
                // ── Alertes ───────────────────────────
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Alertes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  TextButton(onPressed: () {}, child: const Text('Tout voir',
                    style: TextStyle(color: Color(0xFF6b2fa0), fontSize: 12))),
                ]),
                _alertItem(Colors.red, 'Commande #0047 — 2 jours de retard',
                  'Aissatou Diallo · Boubou cérémonie'),
                _alertItem(Colors.orange, 'Essayage demain — Mariama Ba',
                  'Boubou de cérémonie · 10h00'),
                _alertItem(const Color(0xFF1D9E75), 'Commande #0051 terminée',
                  'Kadiatou Camara · prête à livrer'),
                const SizedBox(height: 22),
                // ── Commandes récentes ────────────────
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Commandes récentes',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(ctx, '/commandes'),
                    child: const Text('Voir tout',
                      style: TextStyle(color: Color(0xFF6b2fa0), fontSize: 12))),
                ]),
                ...cmd.commandes.take(4).map((c) => CommandeCard(
                  commande: c,
                  onTap: () {
                    cmd.selectionner(c);
                    Navigator.pushNamed(ctx, '/commande/detail');
                  },
                )),
              ]),
            ),
          ),
          // ── Bottom nav ────────────────────────────
          bottomNavigationBar: _bottomNav(ctx, 0),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(ctx, '/commande/new'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _kpi(String label, String valeur, String sous, {bool dark = false, bool alert = false}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:        dark ? const Color(0xFF1a0a2e) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border:       Border.all(color: const Color(0x1A000000), width: 0.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(
          fontSize: 11, color: dark ? Colors.white54 : const Color(0xFF888780),
          letterSpacing: 0.3)),
        const SizedBox(height: 4),
        Text(valeur, style: TextStyle(
          fontSize:   22,
          fontWeight: FontWeight.w500,
          color:      dark ? Colors.white
                    : alert ? const Color(0xFFE24B4A)
                    : const Color(0xFF6b2fa0))),
        Text(sous, style: TextStyle(
          fontSize: 11, color: dark ? Colors.white38 : const Color(0xFF888780))),
      ]),
    );
  }

  Widget _alertItem(Color dot, String titre, String desc) => Container(
    margin:  const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0x1A000000), width: 0.5)),
    child: Row(children: [
      Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 2, right: 12),
        decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(titre, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        Text(desc,  style: const TextStyle(fontSize: 11, color: Color(0xFF888780))),
      ])),
    ]),
  );

  String _fcfa(dynamic v) {
    final n = (v as num).toInt();
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(0)}k';
    return '$n';
  }

  String _jourSemaine(DateTime d) {
    const j = ['Lun','Mar','Mer','Jeu','Ven','Sam','Dim'];
    return j[d.weekday - 1];
  }

  String _mois(int m) {
    const ms = ['jan','fév','mar','avr','mai','jun','jul','aoû','sep','oct','nov','déc'];
    return ms[m - 1];
  }
}

// ── Bottom navigation helper ──────────────────────────────
Widget _bottomNav(BuildContext ctx, int index) {
  return NavigationBar(
    selectedIndex:      index,
    backgroundColor:    Colors.white,
    indicatorColor:     const Color(0xFFEEEDFE),
    labelBehavior:      NavigationDestinationLabelBehavior.alwaysShow,
    onDestinationSelected: (i) {
      const routes = ['/dashboard', '/clients', '/commandes', '/catalogue', '/agenda'];
      if (i != index) Navigator.pushReplacementNamed(ctx, routes[i]);
    },
    destinations: const [
      NavigationDestination(icon: Icon(Icons.grid_view_outlined),
        selectedIcon: Icon(Icons.grid_view, color: Color(0xFF6b2fa0)), label: 'Accueil'),
      NavigationDestination(icon: Icon(Icons.people_outline),
        selectedIcon: Icon(Icons.people, color: Color(0xFF6b2fa0)), label: 'Clients'),
      NavigationDestination(icon: Icon(Icons.checklist_outlined),
        selectedIcon: Icon(Icons.checklist, color: Color(0xFF6b2fa0)), label: 'Commandes'),
      NavigationDestination(icon: Icon(Icons.style_outlined),
        selectedIcon: Icon(Icons.style, color: Color(0xFF6b2fa0)), label: 'Modèles'),
      NavigationDestination(icon: Icon(Icons.calendar_today_outlined),
        selectedIcon: Icon(Icons.calendar_today, color: Color(0xFF6b2fa0)), label: 'Agenda'),
    ],
  );
}
