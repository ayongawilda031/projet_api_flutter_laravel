<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('category')->latest()->get();
        return response([
            'status' => 'success',
            'products' => $products
        ]);

        
    }

    public function viewProduct($id)
    {
        $product = Product::with('category')->where('id', $id)->first();
        if(empty($product)) {
            return response([
                'status' => 'error',
                'message' => 'Product not found'
            ], 404);
        }
        return response([
            'status' => 'success',
            'product' => $product
        ]);
    }
}
