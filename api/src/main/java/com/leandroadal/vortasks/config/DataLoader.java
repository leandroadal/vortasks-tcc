package com.leandroadal.vortasks.config;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.leandroadal.vortasks.entities.shop.product.Category;
import com.leandroadal.vortasks.entities.shop.product.GemsPackage;
import com.leandroadal.vortasks.entities.shop.product.Product;
import com.leandroadal.vortasks.entities.social.friend.Friendship;
import com.leandroadal.vortasks.entities.user.ProgressData;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.entities.user.UserRole;
import com.leandroadal.vortasks.repositories.shop.CategoryRepository;
import com.leandroadal.vortasks.repositories.shop.GemsPackageRepository;
import com.leandroadal.vortasks.repositories.shop.ProductRepository;
import com.leandroadal.vortasks.repositories.social.FriendshipRepository;
import com.leandroadal.vortasks.repositories.user.UserRepository;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private GemsPackageRepository gemsPackageRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private FriendshipRepository friendshipRepository;

    @Value("${app.initial-load}")
    private boolean initialLoad;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        if (initialLoad) {
            // Cria usuários
            User admin = new User("admin", "admin", "admin@gmail.com", "@Admin01");
            encryptedPassword(admin);
            progressData(100000000, 100000000, 90, 25200f, admin);
            userRepository.save(admin);
            //createBackup(admin);

            User admin1 = new User("admin1", "admin1", "admin1@gmail.com", "@Admin01");
            encryptedPassword(admin1);
            progressData(100000000, 100000000, 90, 25200f, admin1);
            userRepository.save(admin1);
            //createBackup(admin1);

            User user0 = new User("qwertyu", "qwerty", "qwerty@gmail.com", "Ll@12345");
            encryptedPassword(user0);
            progressData(8, 0, 1, 0, user0);
            userRepository.save(user0);
            //createBackup(user0);

            User user = new User("user", "user", "user@gmail.com", "@User123");
            encryptedPassword(user);
            progressData(2548, 1549203, 10, 20, user);
            userRepository.save(user);
            //createBackup(user);

            User user1 = new User("user1", "user1", "user1@gmail.com", "@User123");
            encryptedPassword(user1);
            progressData(2548, 1549203, 10, 20, user1);
            userRepository.save(user1);
            //createBackup(user1);

            User user2 = new User("user2", "user2", "user2@gmail.com", "@User123");
            encryptedPassword(user2);
            progressData(2548, 1549203, 10, 20, user2);
            userRepository.save(user2);
            //createBackup(user2);

            User user3 = new User("user3", "user3", "user3@gmail.com", "@User123");
            encryptedPassword(user3);
            progressData(2548, 1549203, 10, 20, user3);
            userRepository.save(user3);
            //createBackup(user3);

            // Cria amizades entre os usuários
            createFriendship(user, user0);
            createFriendship(user0, user1);
            createFriendship(user, user1);
            createFriendship(user, user2);
            createFriendship(user, user3);
            createFriendship(user2, user3);


            // Cria categorias
            Category category1 = new Category(null, "Icons", new HashSet<>());
            Category category2 = new Category(null, "Themes", new HashSet<>());
            categoryRepository.saveAll(Arrays.asList(category1, category2));

            // Cria produtos
            Product product1 = new Product(null, "Ciclismo", "Ícone de bicicleta para representar ciclismo", "https://drive.google.com/uc?export=view&id=1W2NC39InkezvflHyAqLboeyZdhCfLXGt", 100, 5, 0, true, new HashSet<>());
            Product product2 = new Product(null, "Leitura", "Ícone de livro para representar leitura", "https://drive.google.com/uc?export=view&id=1SoFSpUO-yHjdf89wd11qb4cM8te_fA8T", 150, 8, 0, true, new HashSet<>());
            Product product3 = new Product(null, "Meditação", "Ícone de pessoa meditando para representar meditação", "meditacao", 200, 10, 0, true, new HashSet<>());
            Product product4 = new Product(null, "Cozinhar", "Ícone de panela para representar cozinhar", "https://drive.google.com/uc?export=view&id=1cOjCl2KYnj31iQNxpkJWfeU_inQeFS49", 120, 6, 0, true, new HashSet<>());
            Product product5 = new Product(null, "Estudar", "Ícone de caderno para representar estudar", "https://drive.google.com/uc?export=view&id=1mwUO8cpGqujPqos-TbbT4_iXLYE5RrA1", 180, 9, 0, true, new HashSet<>());
            Product product6 = new Product(null, "Trabalhar", "Ícone de maleta para representar trabalhar", "maleta", 250, 12, 0, true, new HashSet<>());
            Product product7 = new Product(null, "Dormir", "Ícone de lua para representar dormir", "lua", 80, 4, 0, true, new HashSet<>());
            Product product8 = new Product(null, "Exercício", "Ícone de halteres para representar exercício físico", "halteres", 160, 8, 0, true, new HashSet<>());
            Product product9 = new Product(null, "Música", "Ícone de nota musical para representar ouvir música", "nota_musical", 130, 7, 0, true, new HashSet<>());
            Product product10 = new Product(null, "Filme", "Ícone de claquete para representar assistir a um filme", "https://drive.google.com/uc?export=view&id=1JJITHqL-c6tl88d96QvPH7AlZCHEH_g6", 220, 11, 0, true, new HashSet<>());
            Product product11 = new Product(null, "Compras", "Ícone de carrinho de compras para representar fazer compras", "carrinho_compras", 100, 5, 0, true, new HashSet<>());
            Product product12 = new Product(null, "Reunião", "Ícone de pessoas reunidas para representar uma reunião", "reuniao", 200, 10, 0, true, new HashSet<>());
            Product product13 = new Product(null, "Viagem", "Ícone de avião para representar viajar", "aviao", 300, 15, 0, true, new HashSet<>());
            Product product14 = new Product(null, "Passeio", "Ícone de cachorro para representar passear com o cachorro", "cachorro", 90, 4, 0, true, new HashSet<>());
            Product product15 = new Product(null, "Aniversário", "Ícone de bolo para representar um aniversário", "bolo", 170, 9, 0, true, new HashSet<>());
            Product product16 = new Product(null, "Faxina", "Ícone de vassoura para representar faxina", "vassoura", 140, 7, 0, true, new HashSet<>());
            Product product17 = new Product(null, "Jardinagem", "Ícone de flor para representar jardinagem", "flor", 110, 5, 0, true, new HashSet<>());
            Product product18 = new Product(null, "Pet Care", "Ícone de pata de animal para representar cuidar de um pet", "pata_animal", 190, 9, 0, true, new HashSet<>());
            Product product19 = new Product(null, "Hobby", "Ícone de pincel para representar um hobby", "pincel", 150, 8, 0, true, new HashSet<>());
            Product product20 = new Product(null, "Outro", "Ícone de interrogação para representar outras tarefas", "interrogacao", 100, 5, 0, true, new HashSet<>());

            // Associa produtos à categoria
            product1.getCategories().add(category1);
            product2.getCategories().add(category1);
            product3.getCategories().add(category1);
            product4.getCategories().add(category1);
            product5.getCategories().add(category1);
            product6.getCategories().add(category1);
            product7.getCategories().add(category1);
            product8.getCategories().add(category1);
            product9.getCategories().add(category1);
            product10.getCategories().add(category1);
            product11.getCategories().add(category1);
            product12.getCategories().add(category1);
            product13.getCategories().add(category1);
            product14.getCategories().add(category1);
            product15.getCategories().add(category1);
            product16.getCategories().add(category1);
            product17.getCategories().add(category1);
            product18.getCategories().add(category1);
            product19.getCategories().add(category1);
            product20.getCategories().add(category1);

            productRepository.saveAll(Arrays.asList(product1, product2, product3, product4, product5, product6, product7, product8, product9, product10, product11, product12, product13, product14, product15, product16, product17, product18, product19, product20));

            // Cria pacotes de gemas
            GemsPackage gemsPackage1 = new GemsPackage(null, "Pacote Pequeno", "icon3", 100, new BigDecimal("4.99"), 0f, 0);
            GemsPackage gemsPackage2 = new GemsPackage(null, "Pacote Médio", "icon4", 500, new BigDecimal("19.99"), 10f, 0);
            GemsPackage gemsPackage3 = new GemsPackage(null, "Pacote Grande", "gema_grande", 1000, new BigDecimal("39.99"), 20f, 0);
            gemsPackageRepository.saveAll(Arrays.asList(gemsPackage1, gemsPackage2, gemsPackage3));

            initialLoad = false;
        }
    }

    private void encryptedPassword(User user) {
        String encryptedPassword = new BCryptPasswordEncoder().encode(user.getPassword());
        user.setPassword(encryptedPassword);
        user.setRole(UserRole.ADMIN);
    }

    private void progressData(int coins, int gems, int level, float xp, User user) {
        ProgressData progressData = new ProgressData(null, coins, gems, level, xp, null, user);
        user.setProgressData(progressData);
    }

     private void createFriendship(User user1, User user2) {
        Friendship friendship = new Friendship();
        friendship.setUsers(Set.of(user1, user2));
        friendship.setFriendshipDate(Instant.now());
        friendshipRepository.save(friendship);
    }
}
