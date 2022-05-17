//
// Created by os on 5/15/22.
//

#ifndef OS1_KERNEL_LIST_HPP
#define OS1_KERNEL_LIST_HPP

template<typename T>
class List {
    struct Node{
        T data;
        Node *next, *prev;
        Node(const T& d) {
            data = d;
            next = prev = nullptr;
        }
    };

    Node* head, tail;
public:
    List(){
        this->head = this->tail = nullptr;
    }
    void pushBack(const T&);

    void pushFront(const T&);

    T& popBack();

    T& popFront();
};

template<typename T>
void List<T>::pushBack(const T& d) {
}


#endif //OS1_KERNEL_LIST_HPP
