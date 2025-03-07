<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    // Ajouter un produit au panier
    public function addToCart(Request $request, $product_id)
    {
        try {
            // Vérifier si le produit existe
            $product = Product::findOrFail($product_id);

            // Vérifier si le produit est déjà dans le panier de l'utilisateur
            $cartItem = Cart::where('user_id', Auth::id())
                ->where('product_id', $product_id)
                ->first();

            if ($cartItem) {
                // Si le produit est déjà dans le panier, augmenter la quantité
                $cartItem->increment('quantity');
            } else {
                // Sinon, créer un nouvel élément dans le panier
                Cart::create([
                    'user_id' => Auth::id(),
                    'product_id' => $product_id,
                    'quantity' => $request->input('quantity', 1), // Quantité par défaut : 1
                ]);
            }

            return response([
                'status' => 'success',
                'message' => 'Produit ajouté au panier',
            ]);
        } catch (\Exception $e) {
            return response([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Récupérer le panier de l'utilisateur
    public function getCart()
    {
        try {
            $cartItems = Cart::where('user_id', Auth::id())
                ->with('product') // Charger les détails du produit
                ->get();

            return response([
                'status' => 'success',
                'cart' => $cartItems,
            ]);
        } catch (\Exception $e) {
            return response([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Mettre à jour la quantité d'un produit dans le panier
    public function updateCart(Request $request, $cart_id)
    {
        try {
            $cartItem = Cart::where('user_id', Auth::id())
                ->where('id', $cart_id)
                ->firstOrFail();

            $cartItem->update([
                'quantity' => $request->input('quantity'),
            ]);

            return response([
                'status' => 'success',
                'message' => 'Quantité mise à jour',
            ]);
        } catch (\Exception $e) {
            return response([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Supprimer un produit du panier
    public function removeFromCart($cart_id)
    {
        try {
            $cartItem = Cart::where('user_id', Auth::id())
                ->where('id', $cart_id)
                ->firstOrFail();

            $cartItem->delete();

            return response([
                'status' => 'success',
                'message' => 'Produit retiré du panier',
            ]);
        } catch (\Exception $e) {
            return response([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}