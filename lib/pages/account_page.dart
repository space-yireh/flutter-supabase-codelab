import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _loading = false;
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      //  supabase - get profile
    } catch (e) {
      SnackBar(
        content: Text('Unexpected error: $e'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      //  supabase - update profile
    } catch (e) {
      SnackBar(
        content: Text('Unexpected error: $e'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      //  supabase - sign out
    } catch (e) {
      SnackBar(
        content: Text('Unexpected error: $e'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Account')),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _websiteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Website',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loading ? null : _updateProfile,
                    child: Text(_loading ? 'Saving...' : 'Update'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _signOut,
                    child: const Text('Sign out'),
                  ),
                ],
              ));
  }
}
