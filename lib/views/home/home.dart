import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_nusantara/controllers/auth_controller.dart';
import 'package:flutter_crud_nusantara/views/authentication/profil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/book_controller.dart';
import '../../models/book_model.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BookController _bookController = Get.find();
  final AuthController _userController = Get.find();

  void _showAddBookDialog(BuildContext context) {
    TextEditingController isbnController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    TextEditingController publishedController = TextEditingController();
    TextEditingController publisherController = TextEditingController();
    TextEditingController pagesController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController subtitleController = TextEditingController();
    TextEditingController websiteController = TextEditingController();

    // Set nilai awal jika diperlukan
    isbnController.text = "9781449331818";
    titleController.text = "Eloquent JavaScript";
    subtitleController.text = "A Modern Introduction to Programming";
    authorController.text = "Marijn Haverbeke";
    publisherController.text = "No Starch Press";
    publishedController.text = "2011-12-04 00:00:00";
    pagesController.text = "472";
    descriptionController.text =
        "Eloquent JavaScript dives into the JavaScript language to show you how to write beautiful, effective code. It teaches you how to express yourself in code with precision and beauty.";
    websiteController.text = "https://eloquentjavascript.net/";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Buku'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: isbnController,
                  decoration: const InputDecoration(labelText: 'ISBN'),
                ),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul'),
                ),
                TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextFormField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Penulis'),
                ),
                TextFormField(
                  controller: publisherController,
                  decoration: const InputDecoration(labelText: 'Penerbit'),
                ),
                TextFormField(
                  controller: publishedController,
                  decoration: const InputDecoration(labelText: 'Published'),
                ),
                TextFormField(
                  controller: pagesController,
                  decoration:
                      const InputDecoration(labelText: 'Jumlah Halaman'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 4,
                ),
                TextFormField(
                  controller: websiteController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(labelText: 'Website'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Book newBook = Book(
                  isbn: isbnController.text,
                  title: titleController.text,
                  subtitle: subtitleController.text,
                  author: authorController.text,
                  publisher: publisherController.text,
                  published: publishedController.text,
                  pages: int.tryParse(pagesController.text) ?? 0,
                  description: descriptionController.text,
                  website: websiteController.text,
                );

                _bookController.createBook(newBook);
                Navigator.pop(context);
              },
              child: const Text('Tambah Buku'),
            ),
          ],
        );
      },
    );
  }

  void _showEditBookDialog(BuildContext context, Book book) {
    Book editedBook = Book.from(book);

    TextEditingController isbnController =
        TextEditingController(text: editedBook.isbn);
    TextEditingController titleController =
        TextEditingController(text: editedBook.title);
    TextEditingController authorController =
        TextEditingController(text: editedBook.author);
    TextEditingController publishedController =
        TextEditingController(text: editedBook.published);
    TextEditingController publisherController =
        TextEditingController(text: editedBook.publisher);
    TextEditingController pagesController =
        TextEditingController(text: editedBook.pages.toString());
    TextEditingController descriptionController =
        TextEditingController(text: editedBook.description);
    TextEditingController subtitleController =
        TextEditingController(text: editedBook.subtitle);
    TextEditingController websiteController =
        TextEditingController(text: editedBook.website);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Buku'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: isbnController,
                  decoration: const InputDecoration(labelText: 'ISBN'),
                ),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul'),
                ),
                TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextFormField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Penulis'),
                ),
                TextFormField(
                  controller: publisherController,
                  decoration: const InputDecoration(labelText: 'Penerbit'),
                ),
                TextFormField(
                  controller: publishedController,
                  decoration: const InputDecoration(labelText: 'Published'),
                ),
                TextFormField(
                  controller: pagesController,
                  decoration:
                      const InputDecoration(labelText: 'Jumlah Halaman'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 4,
                ),
                TextFormField(
                  controller: websiteController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(labelText: 'Website'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                editedBook = Book(
                  isbn: isbnController.text,
                  title: titleController.text,
                  subtitle: subtitleController.text,
                  author: authorController.text,
                  publisher: publisherController.text,
                  published: publishedController.text,
                  pages: int.tryParse(pagesController.text) ?? 0,
                  description: descriptionController.text,
                  website: websiteController.text,
                );
                _bookController.updateBook(book.id ?? 0, editedBook);
                Navigator.pop(context);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteBookDialog(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Buku'),
        content: const Text('Anda yakin ingin menghapus buku ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _bookController.deleteBook(book.id!);
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _bookController.fetchBooks();
        },
        child: Column(
          children: [
            if (_userController.userProfile.value != null)
              Obx(
                () => Card(
                  color: Colors.deepPurpleAccent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                " Welcome, ${_userController.userProfile.value!.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(() => Profile());
                              },
                              icon: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person_outline_sharp,
                                    size: 50.w,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text("Total Data"),
                                    Text(
                                      _bookController.totalData.toString(),
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text("Halaman saat ini "),
                                    Text(
                                      _bookController.currentPage.toString(),
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text("Total Halaman  "),
                                    Text(
                                      _bookController.totalPages.toString(),
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (_bookController.currentPage.value > 1)
                            ElevatedButton(
                              onPressed: () {
                                _bookController.loadPrevPage();
                              },
                              child: const Text("<"),
                            )
                          else
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent),
                              ),
                              onPressed: () {
                                _bookController.loadPrevPage();
                              },
                              child: const Text(
                                "<",
                              ),
                            ),
                          if (_bookController.currentPage.value <
                              _bookController.totalPages.value)
                            ElevatedButton(
                              onPressed: () {
                                _bookController.loadNextPage();
                              },
                              child: const Text(">"),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                _bookController.loadNextPage();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent),
                              ),
                              child: const Text(">"),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            Expanded(
              child: Obx(
                () {
                  if (_bookController.books.isEmpty) {
                    return const Center(child: Text('Belum ada buku.'));
                  } else {
                    return ListView.builder(
                      itemCount: _bookController.books.length,
                      itemBuilder: (context, index) {
                        final book = _bookController.books[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text(
                                    book.title!,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  subtitle: Text(
                                    book.author ?? '',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  onTap: () {
                                    Get.to(() => BookDetail(bookId: book.id!));
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            size: 20.w,
                                            color: Colors.deepPurpleAccent),
                                        onPressed: () {
                                          _showEditBookDialog(context, book);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20.w,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onPressed: () {
                                          _showDeleteBookDialog(context, book);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBookDialog(context);
        },
        child: Icon(
          Icons.add,
          size: 24.w,
        ),
      ),
    );
  }
}
