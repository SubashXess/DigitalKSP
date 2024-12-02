import 'dart:io';

import 'package:digitalksp/providers/jobs_providers.dart';
import 'package:digitalksp/utilities/utilities.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/models/jobs/jobs_models.dart';
import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:digitalksp/widgets/form_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ApplyJobPage extends StatefulWidget {
  const ApplyJobPage({super.key, required this.jobDetails});

  final JobPostModel? jobDetails;

  @override
  State<ApplyJobPage> createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _ctcController;
  late final TextEditingController _currentCompanyController;
  late final TextEditingController _resumeController;

  late final FocusNode _nameNode;
  late final FocusNode _emailNode;
  late final FocusNode _mobileNode;
  late final FocusNode _ctcNode;
  late final FocusNode _currentCompanyNode;
  late final FocusNode _resumeNode;

  Map<String, dynamic>? _selectedResume;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()..addListener(_onListen);
    _emailController = TextEditingController()..addListener(_onListen);
    _mobileController = TextEditingController()..addListener(_onListen);
    _ctcController = TextEditingController()..addListener(_onListen);
    _currentCompanyController = TextEditingController()..addListener(_onListen);
    _resumeController = TextEditingController()..addListener(_onListen);

    _nameNode = FocusNode();
    _emailNode = FocusNode();
    _mobileNode = FocusNode();
    _ctcNode = FocusNode();
    _currentCompanyNode = FocusNode();
    _resumeNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _ctcController.dispose();
    _currentCompanyController.dispose();
    _resumeController.dispose();

    _nameController.removeListener(_onListen);
    _emailController.removeListener(_onListen);
    _mobileController.removeListener(_onListen);
    _ctcController.removeListener(_onListen);
    _currentCompanyController.removeListener(_onListen);
    _resumeController.removeListener(_onListen);

    _nameNode.dispose();
    _emailNode.dispose();
    _mobileNode.dispose();
    _ctcNode.dispose();
    _currentCompanyNode.dispose();
    _resumeNode.dispose();

    super.dispose();
  }

  void _onListen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(title: const Text('Apply Job')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadius),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.jobDetails?.jobTitle ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/office-outlined.svg',
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.36),
                                BlendMode.srcIn),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              widget.jobDetails?.companyName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Colors.black.withOpacity(0.56),
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location-outlined.svg',
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.36),
                                BlendMode.srcIn),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              widget.jobDetails?.location ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Colors.black.withOpacity(0.56),
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadius),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundedFormField(
                        controller: _nameController,
                        node: _nameNode,
                        label: 'Full Name',
                        hintText: 'e.g. John Doe',
                        capitalization: TextCapitalization.words,
                        autofillHints: const [
                          AutofillHints.name,
                          AutofillHints.namePrefix,
                          AutofillHints.nameSuffix,
                          AutofillHints.givenName,
                          AutofillHints.nickname,
                          AutofillHints.familyName,
                          AutofillHints.middleName
                        ],
                        keyboardType: TextInputType.name,
                        maxLength: 60,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Full name is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 14.0),
                      RoundedFormField(
                        controller: _mobileController,
                        node: _mobileNode,
                        label: 'Phone Number',
                        hintText: 'e.g. +91 5555 555555',
                        autofillHints: const [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.phone,
                        maxLength: 14,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Provide your phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 14.0),
                      RoundedFormField(
                        controller: _emailController,
                        node: _emailNode,
                        label: 'Email Address',
                        hintText: 'e.g. john@example.com',
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.name,
                        maxLength: 60,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 14.0),
                      RoundedFormField(
                        controller: _ctcController,
                        node: _ctcNode,
                        label: 'Current CTC',
                        hintText: 'e.g. 3,50,000',
                        keyboardType: TextInputType.number,
                        maxLength: 14,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 14.0),
                      RoundedFormField(
                        controller: _currentCompanyController,
                        node: _currentCompanyNode,
                        label: 'Current Company',
                        hintText: 'e.g. Company Name Pvt. Ltd',
                        maxLength: 60,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 14.0),
                      Text('Upload Your CV/Resume',
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: _selectedResume != null
                            ? null
                            : () async {
                                await Utilities.pickFile(allowedExtensions: [
                                  'pdf',
                                  'doc',
                                  'docx'
                                ], type: FileType.custom)
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedResume = value;
                                    });
                                  }
                                });
                              },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppDimensions.borderRadius),
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: _selectedResume != null
                              ? Row(
                                  children: [
                                    SvgPicture.asset(
                                      {
                                            'pdf': 'assets/icons/pdf.svg',
                                            'doc': 'assets/icons/doc.svg',
                                            'docx': 'assets/icons/docx.svg',
                                          }[_selectedResume?['fileExtension']
                                              ?.toLowerCase()] ??
                                          'assets/icons/doc-outlined.svg',
                                      width: 36.0,
                                      height: 36.0,
                                      fit: BoxFit.contain,
                                      // colorFilter: ColorFilter.mode(
                                      //     Theme.of(context).primaryColor,
                                      //     BlendMode.srcIn),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_selectedResume?['originalFileName']}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            _selectedResume?['fileSize'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedResume = null;
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/icons/delete-outlined.svg',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.contain,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.red, BlendMode.srcIn),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/file-upload-outlined.svg',
                                      width: 28.0,
                                      height: 28.0,
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.68),
                                          BlendMode.srcIn),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Browse File',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RoundedButton(
              label: 'Submit',
              onTap: _loading
                  ? () {}
                  : () {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedResume != null) {
                          // Success
                          setState(() {
                            _loading = true;
                          });
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                          final provider = context.read<JobsProviders>();
                          provider
                              .applyJob(
                            context,
                            job: JobApplyModel(
                              jobId: widget.jobDetails!.id,
                              name: _nameController.text.trim(),
                              phone: _mobileController.text.trim(),
                              email: _emailController.text.trim(),
                              ctc: _ctcController.text.trim(),
                              company: _currentCompanyController.text.trim(),
                              resume: File(_selectedResume?['filePath']),
                            ),
                          )
                              .then(
                            (_) {
                              _nameController.clear();
                              _mobileController.clear();
                              _emailController.clear();
                              _ctcController.clear();
                              _currentCompanyController.clear();
                              _selectedResume = null;

                              setState(() {
                                _loading = false;
                              });
                            },
                          );
                          _loading ? null : Navigator.pop(context);
                        }
                      } else {
                        // Error
                      }
                    },
            ),
          ),
        ),
      ),
    );
  }
}
