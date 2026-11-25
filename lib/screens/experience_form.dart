import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _role = "";
  String _description = "";
  String _category = "Organization";
  String _thumbnail = "";
  String _startedAt = "";
  String _endedAt = "";

  bool _showStartDateError = false;
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Organization',
    'Committee',
    'Part-Time',
    'Volunteering',
    'Other',
  ];

  String _formatDate(DateTime date) {
    return "${date.year}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value.trim());

    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.hasAuthority &&
        uri.host.isNotEmpty;
  }

  Future<void> _selectStartDate() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (pickedDate == null) return;

    setState(() {
      _startedAt = _formatDate(pickedDate);
      _showStartDateError = false;

      // Jika End Date lebih awal dari Start Date,
      // kosongkan End Date agar pengguna memilih ulang.
      if (_endedAt.isNotEmpty &&
          DateTime.parse(_endedAt).isBefore(pickedDate)) {
        _endedAt = "";
      }
    });
  }

  Future<void> _selectEndDate() async {
    final now = DateTime.now();

    final startDate = _startedAt.isEmpty
        ? DateTime(2000)
        : DateTime.parse(_startedAt);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: startDate,
      lastDate: now,
    );

    if (pickedDate == null) return;

    setState(() {
      _endedAt = _formatDate(pickedDate);
    });
  }

  void _resetForm() {
    _formKey.currentState?.reset();

    setState(() {
      _title = "";
      _role = "";
      _description = "";
      _category = "Organization";
      _thumbnail = "";
      _startedAt = "";
      _endedAt = "";
      _showStartDateError = false;
    });
  }

  Future<void> _saveForm() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_startedAt.isEmpty) {
      setState(() {
        _showStartDateError = true;
      });
      return;
    }

    if (_endedAt.isNotEmpty &&
        DateTime.parse(_endedAt).isBefore(DateTime.parse(_startedAt))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("End Date cannot be before Start Date.")),
      );
      return;
    }

    // Pastikan pengguna sudah login.
    final loggedIn = await ensureLoggedIn(context);

    if (!loggedIn || !mounted) return;

    final authState = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();

    final token = authState.token;

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please login first.")));
      return;
    }

    // Buat object Experience sesuai model Django.
    final newExperience = Experience(
      title: _title.trim(),
      role: _role.trim(),
      description: _description.trim(),
      category: _category,
      thumbnail: _thumbnail.trim().isEmpty ? null : _thumbnail.trim(),
      startedAt: DateTime.parse(_startedAt),
      endedAt: _endedAt.isEmpty ? null : DateTime.parse(_endedAt),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Kirim data Experience ke backend.
      await apiClient.createExperience(newExperience, token: token);

      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      // Tampilkan data yang berhasil disimpan.
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Experience Saved!"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Title: ${newExperience.title}"),
                  Text(
                    "Role: ${newExperience.role.isEmpty ? "-" : newExperience.role}",
                  ),
                  Text("Description: ${newExperience.description}"),
                  Text("Category: ${newExperience.category}"),
                  Text("Thumbnail: ${newExperience.thumbnail ?? "-"}"),
                  Text("Start Date: ${_formatDate(newExperience.startedAt)}"),
                  Text(
                    "End Date: ${newExperience.endedAt == null ? "Ongoing" : _formatDate(newExperience.endedAt!)}",
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _resetForm();
                },
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      // Jika token sudah tidak valid.
      if (e.statusCode == 401) {
        await authState.logout();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Session expired. Please login again.")),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save experience: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Experience Form")),
        backgroundColor: const Color(0xFF500B1B),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Experience Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter experience title",
                    labelText: "Experience Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _title = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Experience title cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // Role
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your role",
                    labelText: "Role",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _role = value;
                  },
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Describe your experience",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _description = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // Category
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _category = newValue;
                      });
                    }
                  },
                ),
              ),

              // Thumbnail URL
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter thumbnail URL (optional)",
                    labelText: "Thumbnail URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _thumbnail = value;
                  },
                  validator: (value) {
                    final trimmedValue = value?.trim() ?? "";

                    if (trimmedValue.isNotEmpty && !_isValidUrl(trimmedValue)) {
                      return "Enter a valid HTTP or HTTPS URL!";
                    }

                    return null;
                  },
                ),
              ),

              // Start Date
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text("Start Date"),
                      subtitle: Text(
                        _startedAt.isEmpty ? "Select start date" : _startedAt,
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      onTap: _isSubmitting ? null : _selectStartDate,
                    ),
                    if (_showStartDateError)
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 4.0),
                        child: Text(
                          "Start Date is required!",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),

              // End Date
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text("End Date"),
                  subtitle: Text(
                    _endedAt.isEmpty ? "Select end date (optional)" : _endedAt,
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onTap: _isSubmitting ? null : _selectEndDate,
                ),
              ),

              // Save Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF500B1B),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _isSubmitting ? null : _saveForm,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text("Save"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
