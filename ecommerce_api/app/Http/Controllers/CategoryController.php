<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Product;



class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::latest()->get();
        return response([
            'status' => 'success',
            'categories' => $categories
        ]);
    }

    public function fetchProductUnderCategory($id)
    {
        $products = Product::with('category')->where('category_id', $id)->latest()->get();
        return response([
            'status' => 'success',
            'products' => $products
        ]);
    }
}
