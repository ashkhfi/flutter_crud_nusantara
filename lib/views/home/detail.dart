import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/book_controller.dart';
import '../../models/book_model.dart';

class BookDetail extends StatelessWidget {
  final int bookId;

  const BookDetail({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final BookController bookController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        centerTitle: true,
        elevation: 0, 
      ),
      body: FutureBuilder<Book>(
        future: bookController.getBookDetail(bookId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak tersedia'));
          } else {
            final Book book = snapshot.data!;

            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                buildHeader(book.title ?? ''),
                SizedBox(height: 16.h),
                buildDetailSection('Subtitle', book.subtitle ?? ''),
                buildDetailSection('Author', book.author ?? ''),
                buildDetailSection('Published', book.published ?? ''),
                buildDetailSection('Publisher', book.publisher ?? ''),
                buildDetailSection('Pages', book.pages?.toString() ?? ''),
                buildDetailSection('Description', book.description ?? ''),
                buildDetailSection('Website', book.website ?? ''),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildHeader(String title) {
    return Card(
      child: SizedBox(
        height: 200.h,
        // decoration: BoxDecoration(
        //   color: Colors.purple, // Ganti warna latar belakang sesuai keinginan (warna ungu)
        // ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailSection(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp),
          ),
          const Divider(color: Colors.grey), // Garis pemisah antar seksi
        ],
      ),
    );
  }
}
