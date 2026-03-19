import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/commande_provider.dart';
import '../providers/client_provider.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginCtrl = TextEditingController(text: kDemoMode ? 'admin' : '');
  final _passCtrl  = TextEditingController(text: kDemoMode ? 'demo123' : '');
  bool  _loading   = false;
  bool  _showPass  = false;
  String? _erreur;

  Future<void> _submit() async {
    setState(() { _loading = true; _erreur = null; });
    final ok = await context.read<AuthProvider>().login(
      _loginCtrl.text.trim(), _passCtrl.text);
    if (!mounted) return;
    if (ok) {
      await context.read<CommandeProvider>().chargerCommandes();
      await context.read<ClientProvider>().chargerClients();
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() { _loading = false; _erreur = 'Identifiant ou mot de passe incorrect.'; });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color(0xFF1a0a2e), Color(0xFF3d1a6e), Color(0xFF6b2fa0)])),
      child: SafeArea(child: Center(child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // ── Logo ──────────────────────────────────────
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white24)),
            child: const Icon(Icons.cut, size: 40, color: Colors.white)),
          const SizedBox(height: 20),
          const Text('Atelier Pro', style: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          if (kDemoMode)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20)),
              child: const Text('Mode démonstration',
                style: TextStyle(color: Colors.white70, fontSize: 12)))
          else
            const Text('Connectez-vous à votre atelier',
              style: TextStyle(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 40),
          // ── Champ login ───────────────────────────────
          TextField(
            controller: _loginCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:       'Identifiant ou téléphone',
              hintStyle:      const TextStyle(color: Colors.white38),
              prefixIcon:     const Icon(Icons.person_outline, color: Colors.white54),
              filled:         true,
              fillColor:      Colors.white.withOpacity(0.12),
              border:         OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:   BorderSide(color: Colors.white.withOpacity(0.2))),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:   BorderSide(color: Colors.white.withOpacity(0.2))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:   const BorderSide(color: Colors.white54)),
            )),
          const SizedBox(height: 14),
          // ── Champ mot de passe ────────────────────────
          TextField(
            controller:     _passCtrl,
            obscureText:    !_showPass,
            style:          const TextStyle(color: Colors.white),
            onSubmitted:    (_) => _submit(),
            decoration: InputDecoration(
              hintText:      'Mot de passe',
              hintStyle:     const TextStyle(color: Colors.white38),
              prefixIcon:    const Icon(Icons.lock_outline, color: Colors.white54),
              suffixIcon:    IconButton(
                icon: Icon(_showPass ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white54),
                onPressed: () => setState(() => _showPass = !_showPass)),
              filled:        true,
              fillColor:     Colors.white.withOpacity(0.12),
              border:        OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(color: Colors.white.withOpacity(0.2))),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(color: Colors.white.withOpacity(0.2))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  const BorderSide(color: Colors.white54)),
            )),
          if (_erreur != null) ...[
            const SizedBox(height: 10),
            Text(_erreur!, style: const TextStyle(color: Color(0xFFF09595), fontSize: 13)),
          ],
          const SizedBox(height: 24),
          // ── Bouton ────────────────────────────────────
          SizedBox(width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3d1a6e),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _loading ? null : _submit,
              child: _loading
                ? const SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF3d1a6e)))
                : const Text('Se connecter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            )),
        ]),
      ))),
    ),
  );
}
