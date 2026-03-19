import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/commande_provider.dart';
import 'providers/client_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/commandes_list_screen.dart';
import 'screens/commande_detail_screen.dart';
import 'screens/commande_form_screen.dart';
import 'screens/clients_list_screen.dart';
import 'screens/client_detail_screen.dart';
import 'screens/catalogue_screen.dart';
import 'screens/agenda_screen.dart';

// ── Mode démo : true = données fictives, false = API Django réelle
const bool kDemoMode = bool.fromEnvironment('DEMO_MODE', defaultValue: true);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AtelierApp());
}

class AtelierApp extends StatelessWidget {
  const AtelierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CommandeProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
      child: MaterialApp(
        title:        'Atelier Pro',
        debugShowCheckedModeBanner: false,
        theme:        _buildTheme(),
        initialRoute: '/splash',
        routes: {
          '/splash':           (_) => const SplashScreen(),
          '/login':            (_) => const LoginScreen(),
          '/dashboard':        (_) => const DashboardScreen(),
          '/commandes':        (_) => const CommandesListScreen(),
          '/commande/detail':  (_) => const CommandeDetailScreen(),
          '/commande/new':     (_) => const CommandeFormScreen(),
          '/clients':          (_) => const ClientsListScreen(),
          '/client/detail':    (_) => const ClientDetailScreen(),
          '/catalogue':        (_) => const CatalogueScreen(),
          '/agenda':           (_) => const AgendaScreen(),
        },
      ),
    );
  }

  ThemeData _buildTheme() {
    const primary   = Color(0xFF6b2fa0);
    const dark      = Color(0xFF1a0a2e);
    const bg        = Color(0xFFF7F5F0);

    return ThemeData(
      useMaterial3:      true,
      colorScheme:       ColorScheme.fromSeed(
        seedColor:       primary,
        primary:         primary,
        secondary:       dark,
        surface:         Colors.white,
        surfaceContainerHighest: bg,
      ),
      scaffoldBackgroundColor: bg,
      appBarTheme: const AppBarTheme(
        backgroundColor:  dark,
        foregroundColor:  Colors.white,
        elevation:        0,
        centerTitle:      false,
        titleTextStyle:   TextStyle(
          fontFamily: 'Roboto',
          fontSize:   17,
          fontWeight: FontWeight.w500,
          color:      Colors.white,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled:    true,
        fillColor: Colors.white,
        border:    OutlineInputBorder(borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0x26000000), width: 0.5)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0x26000000), width: 0.5)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primary, width: 1)),
      ),
      cardTheme: CardTheme(
        color:     Colors.white,
        elevation: 0,
        shape:     RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0x1A000000), width: 0.5),
        ),
      ),
    );
  }
}
