import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../widgets/flip_card_widget.dart';

class StudyScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  final int initialIndex;

  const StudyScreen({
    super.key,
    required this.flashcards,
    this.initialIndex = 0,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  late int _index;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  Flashcard get _current => widget.flashcards[_index];

  void _next() {
    setState(() {
      _index = (_index + 1) % widget.flashcards.length;
      _showAnswer = false;
    });
  }

  void _previous() {
    setState(() {
      _index = (_index - 1 + widget.flashcards.length) % widget.flashcards.length;
      _showAnswer = false;
    });
  }

  void _toggleAnswer() {
    setState(() => _showAnswer = !_showAnswer);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Study')),
        body: const Center(child: Text('No flashcards to study yet.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Card ${_index + 1} of ${widget.flashcards.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: FlipCardWidget(
                  question: _current.question,
                  answer: _current.answer,
                  category: _current.category,
                  showAnswer: _showAnswer,
                  onTap: _toggleAnswer,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _toggleAnswer,
              icon: Icon(_showAnswer ? Icons.visibility_off : Icons.visibility),
              label: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _previous,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _next,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}