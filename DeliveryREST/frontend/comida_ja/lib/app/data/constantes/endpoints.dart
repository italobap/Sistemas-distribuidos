class Endpoints {
  static String getRestaurantes = "/restaurants";

  static String getCardapio(int idRestaurante) =>
      "/restaurants/$idRestaurante/menu";
  static String postPedido = "/orders";
  static String postCarrinho = "/cart";
}
