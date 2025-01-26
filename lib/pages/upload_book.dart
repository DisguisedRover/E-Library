import 'dart:async';
import 'dart:io';
import 'package:book_library/models/books.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadBookPage extends StatefulWidget {
  const UploadBookPage({super.key});

  @override
  State<UploadBookPage> createState() => _UploadBookPageState();
}

class _UploadBookPageState extends State<UploadBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  BookFaculty? _selectedFaculty;
  XFile? _imageFile;
  PlatformFile? _pdfFile;
  bool _isLoading = false;
  String _uploadMessage = '';

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  Future<void> _pickPdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Only allow PDF files
      );

      if (result != null) {
        setState(() {
          _pdfFile = result.files.first;
        });
      }
    } catch (e) {
      setState(() {
        _uploadMessage = 'Error picking PDF: $e';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking PDF: $e')),
      );
    }
  }

  Future<void> _uploadBook() async {
    if (_isLoading) return;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _uploadMessage = '';
      });

      final url = Uri.parse('http://192.168.18.90:5000/books');
      final request = http.MultipartRequest('POST', url);

      // Add form fields
      request.fields['title'] = _titleController.text;
      request.fields['author'] = _authorController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['faculty'] = _selectedFaculty!.toString().split('.').last;

      print('Uploading files...');

      try {
        // Handle image file
        if (_imageFile != null) {
          print('Adding image file: ${_imageFile!.path}');
          final imageFile = await http.MultipartFile.fromPath(
              'cover', _imageFile!.path, // Changed from name to path
              filename: _imageFile!.name);
          request.files.add(imageFile);
        }

        // Handle PDF file
        if (_pdfFile != null) {
          print('Adding PDF file: ${_pdfFile!.path}');
          final file = File(_pdfFile!.path!);
          final bytes = await file.readAsBytes();
          final pdfFile = http.MultipartFile.fromBytes(
            'pdf',
            bytes,
            filename: _pdfFile!.name,
          );
          request.files.add(pdfFile);
        }

        print('Sending request...');
        final response = await request
            .send()
            .timeout(const Duration(seconds: 180), onTimeout: () {
          throw TimeoutException('Upload time out. Please try again.');
        });
        print('Response status: ${response.statusCode}');

        final respStr = await response.stream.bytesToString();
        print('Response body: $respStr');

        if (response.statusCode == 201) {
          setState(() {
            _isLoading = false;
            _uploadMessage = 'Book uploaded successfully!';
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Book uploaded successfully')));
        } else {
          setState(() {
            _isLoading = false;
            _uploadMessage =
                'Failed to upload book. Status code: ${response.statusCode}\n$respStr';
          });
          print(
              'Failed to upload book. Status code: ${response.statusCode}\n$respStr');
        }
      } catch (e, stackTrace) {
        print('Error uploading book: $e');
        print('Stack trace: $stackTrace');
        setState(() {
          _isLoading = false;
          _uploadMessage = 'Error uploading book: $e';
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error uploading book: $e")));
      }
    } else if (_selectedFaculty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a faculty")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Book')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<BookFaculty>(
                decoration: const InputDecoration(labelText: 'Faculty'),
                value: _selectedFaculty,
                items: BookFaculty.values.map((faculty) {
                  return DropdownMenuItem<BookFaculty>(
                    value: faculty,
                    child: Text(faculty.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFaculty = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a faculty';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Cover Image'),
              ),
              if (_imageFile != null)
                Text('Selected Image: ${_imageFile!.name}'),
              ElevatedButton(
                onPressed: _pickPdf,
                child: const Text('Pick Pdf'),
              ),
              if (_pdfFile != null) Text('Selected Pdf: ${_pdfFile!.name}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _uploadBook,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Upload Book'),
              ),
              if (_uploadMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(_uploadMessage),
                )
            ],
          ),
        ),
      ),
    );
  }
}
