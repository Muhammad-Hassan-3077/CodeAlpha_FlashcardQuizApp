import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/flashcard.dart';
import 'add_edit_flashcard_screen.dart';
import 'study_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flashcard> _flashcards = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    setState(() => _loading = true);
    final cards = await DatabaseHelper.instance.getAllFlashcards();
    setState(() {
      _flashcards = cards;
      _loading = false;
    });
  }

  Future<void> _addFlashcard() async {
    final result = await Navigator.of(context).push<Flashcard>(
      MaterialPageRoute(builder: (_) => const AddEditFlashcardScreen()),
    );
    if (result != null) {
      await DatabaseHelper.instance.insertFlashcard(result);
      _loadFlashcards();
    }
  }

  Future<void> _editFlashcard(Flashcard flashcard) async {
    final result = await Navigator.of(context).push<Flashcard>(
      MaterialPageRoute(
        builder: (_) => AddEditFlashcardScreen(flashcard: flashcard),
      ),
    );
    if (result != null) {
      await DatabaseHelper.instance.updateFlashcard(result);
      _loadFlashcards();
    }
  }

  Future<void> _deleteFlashcard(Flashcard flashcard) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && flashcard.id != null) {
      await DatabaseHelper.instance.deleteFlashcard(flashcard.id!);
      _loadFlashcards();
    }
  }

  void _startStudying({int startIndex = 0}) {
    if (_flashcards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add a flashcard first to start studying.')),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StudyScreen(
          flashcards: _flashcards,
          initialIndex: startIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_fill),
            tooltip: 'Study all cards',
            onPressed: () => _startStudying(),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _flashcards.isEmpty
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'No flashcards yet.\nTap + to add your first flashcard!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _flashcards.length,
        itemBuilder: (context, index) {
          final card = _flashcards[index];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                card.question,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(card.category),
              onTap: () => _startStudying(startIndex: index),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () => _editFlashcard(card),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () => _deleteFlashcard(card),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: const Icon(Icons.add),
      ),
    );
  }
}